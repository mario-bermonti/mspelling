/// Data manager

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:data/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

part 'db.g.dart';

/// Return the path to the downloads folder
/// It is aware of different OS
Future<String> _getPath() async {
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    Directory? dir = await getDownloadsDirectory();
    if (dir == null) throw Exception("Downloads folder not available");
    return dir.path;
  }

  if (Platform.isAndroid && await Permission.storage.request().isGranted) {
    return '/storage/emulated/0/Download/';
  } else {
    throw Exception(
        "Permission required to save files to the Downloads folder.");
  }
}

/// Provide a database to be used
/// The database is created or used from a location based on the OS.
LazyDatabase _dbProvider() {
  return LazyDatabase(() async {
    String path = await _getPath();
    final file = File(p.join(path, 'mspelling_data.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Sessions, Trials, Devices])
class DataBase extends _$DataBase {
  /// Data manager

  late SessionsCompanion sessionData;
  late DevicesCompanion deviceData;
  List<TrialsCompanion> trialsData = <TrialsCompanion>[];

  DataBase({Function connectionOpenner = _dbProvider})
      : super(connectionOpenner());

  @override
  int get schemaVersion => 1;

  ////////////////
  // inserters //
  //////////////

  Future<int> insertTrial(TrialsCompanion trial) => into(trials).insert(trial);
  Future<int> insertSession(SessionsCompanion session) =>
      into(sessions).insert(session);
  Future<int> insertDevice(DevicesCompanion device) =>
      into(devices).insert(device);
  Future<void> insertTrials() async {
    await batch((batch) => batch.insertAll(trials, trialsData));
  }

  //////////////
  // getters //
  ////////////

  Future<Trial> getTrial(int id) {
    return (select(trials)..where((trial) => trial.id.equals(id))).getSingle();
  }

  Future<List<Trial>> getTrials() => select(trials).get();

  Future<Session> getSession(int id) {
    return (select(sessions)..where((session) => session.id.equals(id)))
        .getSingle();
  }

  Future<Device> getDevice(int id) {
    return (select(devices)..where((device) => device.id.equals(id)))
        .getSingle();
  }

  /// TODO Fix in the future
  /// It is currently causing problems with key mismatch
  // @override
  // MigrationStrategy get migration => MigrationStrategy(
  //       beforeOpen: (OpeningDetails details) async {
  //         await customStatement('PRAGMA foreign_keys = ON');
  //       },
  //     );

  /// Returns the appropriate current session number for the current participant
  /// based on how many sessions the participant has completed before.
  Future<int> getCurrentParticipantSessionNumber(String participantId) async {
    final List<Session> result = await (select(sessions)
          ..where((session) => session.participantId.equals(participantId)))
        .get();
    return result.length + 1;
  }
  /////////////
  // Adders //
  ///////////

  /// Add data for the current session to later be saved to the db
  void addSessionData({
    required int sessionNumber,
    required String participantId,
    required DateTime timeStart,
    required DateTime timeEnd,
  }) {
    sessionData = SessionsCompanion(
      sessionNumber: Value(sessionNumber),
      participantId: Value(participantId),
      timeStart: Value(timeStart),
      timeEnd: Value(timeEnd),
    );
  }

  /// Add data for the current device to later be saved to the db
  void addDeviceData({
    required String participantId,
    required int sessionNumber,
  }) {
    deviceData = DevicesCompanion(
      participantId: Value(participantId),
      sessionNumber: Value(sessionNumber),
    );
  }

  /// Add data for the current device to later be saved to the db
  void addTrialData({
    required String participantId,
    required String stim,
    required String resp,
    required int sessionNumber,
  }) {
    TrialsCompanion trial = TrialsCompanion(
      participantId: Value(participantId),
      stim: Value(stim),
      resp: Value(resp),
      sessionNumber: Value(sessionNumber),
    );

    trialsData.add(trial);
  }

  /// Save all collected data to db (disk)
  void saveData() {
    insertSession(sessionData);
    insertDevice(deviceData);
    insertTrials();
  }
}