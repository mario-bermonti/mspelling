import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mspelling/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

part 'data.g.dart';

/// Return appropriate directory path for saving data depending on the OS
Future<String> getPath() async {
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    Directory? dir = await getDownloadsDirectory();
    if (dir == null) throw Exception("Downloads folder not available");
    return dir.path;
  }
  if (Platform.isAndroid) {
    if (await Permission.storage.request().isGranted) {
      Directory? dir = await getExternalStorageDirectory();
      if (dir == null) throw Exception("External storage folder not available");
      return dir.path;
    }
  }
  throw Exception("No dir for saving db could be accessed");
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    String path = await getPath();
    print("current path $path");
    final file = File(p.join(path, 'mspelling_data.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Sessions, Trials, Devices])
class MyDatabase extends _$MyDatabase {
  late SessionsCompanion sessionData;
  late DevicesCompanion deviceData;
  List<TrialsCompanion> trialsData = <TrialsCompanion>[];

  MyDatabase({Function connectionOpenner = _openConnection})
      : super(connectionOpenner());

  @override
  int get schemaVersion => 1;

  ////////////////
  // inserters //
  //////////////

  Future<int> insertTrial(TrialsCompanion trial) => into(trials).insert(trial);
  Future insertSession(SessionsCompanion session) =>
      into(sessions).insert(session);
  Future insertDevice(DevicesCompanion device) => into(devices).insert(device);
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
          ..where((session) => session.participantId.equals(participantId))
          ..orderBy([
            (session) =>
                OrderingTerm(expression: session.sessionNumberParticipant)
          ]))
        .get();
    return result.length + 1;
  }
  /////////////
  // Adders //
  ///////////

  /// Add data for the current session to later be saved to the db
  void addSessionData({
    required int sessionNumberParticipant,
    required String participantId,
    required DateTime timeStart,
    required DateTime timeEnd,
  }) {
    sessionData = SessionsCompanion(
      sessionNumberParticipant: Value(sessionNumberParticipant),
      participantId: Value(participantId),
      timeStart: Value(timeStart),
      timeEnd: Value(timeEnd),
    );
  }

  /// Add data for the current device to later be saved to the db
  void addDeviceData({
    required String participantId,
    required int session,
  }) {
    deviceData = DevicesCompanion(
      participantId: Value(participantId),
      session: Value(session),
    );
  }

  /// Add data for the current device to later be saved to the db
  void addTrialData({
    required String participantId,
    required String stim,
    required String resp,
    required int session,
  }) {
    TrialsCompanion trial = TrialsCompanion(
      participantId: Value(participantId),
      stim: Value(stim),
      resp: Value(resp),
      session: Value(session),
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
