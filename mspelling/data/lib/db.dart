/// Data manager

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:data/models.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:data/errors.dart';

part 'db.g.dart';

/// Get permission to use the path provided if necessary
/// Throws error if permission is needed and not granted
/// [path] Path where to create or get the db from
Future<void> getPermissionIfNecessary({required String path}) async {
  if (Platform.isAndroid) {
    bool granted = await Permission.storage.request().isGranted;
    if (!granted) {
      throw PermissionNotGrantedException();
    }
  }
}

/// Provide a database to be used
/// [path] Path where to create or get the db from
LazyDatabase _dbProvider({required String path}) {
  return LazyDatabase(() async {
    await getPermissionIfNecessary(path: path);
    final file = File(path);
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Sessions, Trials, Devices])
class DataBase extends _$DataBase {
  /// Data manager

  late SessionsCompanion sessionData;
  late DevicesCompanion deviceData;
  List<TrialsCompanion> trialsData = <TrialsCompanion>[];

  /// Create db instance
  /// [_dbProvider] Function that provides the db that will be used
  /// [path] Path where to create or get the db
  DataBase({
    Function connectionOpenner = _dbProvider,
    required String path,
  }) : super(connectionOpenner(path: path));

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

// TODO Improve organization of code
/// Create a db and return it
/// [path] Path where to create or get the db from
Future<DataBase> getDB({required String path}) async {
  DataBase db = DataBase(path: path);
  return db;
}
