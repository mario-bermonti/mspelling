import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mspelling/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'data.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Sessions, Trials, Devices])
class MyDatabase extends _$MyDatabase {
  MyDatabase({Function connectionOpenner = _openConnection})
      : super(connectionOpenner());

  @override
  int get schemaVersion => 1;

  /// inserts
  Future<int> insertTrial(TrialsCompanion trial) => into(trials).insert(trial);
  Future insertSession(SessionsCompanion session) =>
      into(sessions).insert(session);
  Future insertDevice(DevicesCompanion device) => into(devices).insert(device);

  /// get
  Future<Trial> getTrial(int id) {
    return (select(trials)..where((trial) => trial.id.equals(id))).getSingle();
  }

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
}
