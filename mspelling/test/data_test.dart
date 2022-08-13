import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:test/test.dart';
import 'package:mspelling/data.dart';

void main() {
  late MyDatabase database;

  setUp(() {
    database = MyDatabase(connectionOpenner: connectionOpenerTest);
  });

  tearDown(() async {
    database.close();
  });
}

connectionOpenerTest() => NativeDatabase.memory();
