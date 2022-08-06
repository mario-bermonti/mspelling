import 'dart:io';

import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:mspelling/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'data.g.dart';

@drift.DriftDatabase(tables: [Sessions, Trials, Devices])
class Data extends _$Data {
  Data() : super(_openConnection);

  @override
  int get schemaVersion => 1;
}

drift.LazyDatabase _openConnection() {
  return drift.LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
