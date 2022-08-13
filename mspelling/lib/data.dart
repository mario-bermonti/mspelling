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

  Future insertTrial(Trial trial) => into(trials).insert(trial);
  Future insertSession(Session session) => into(sessions).insert(session);
  Future insertDevice(Device device) => into(devices).insert(device);
}
