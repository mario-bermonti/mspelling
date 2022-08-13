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

  flutter_test.testWidgets('save single trial to database', (tester) async {
    /// exp
    var exp = const TrialsCompanion(
      participantId: Value('001'),
      session: Value(1),
      stim: Value('gato'),
      resp: Value('gato'),
    );
    final int expId = await database.insertTrial(exp);

    /// obs
    final trialDatabase = await database.getTrial(expId);
    final TrialsCompanion obs = trialDatabase.toCompanion(true);

    /// checks
    /// TODO Check if there is a simpler way to compare them
    /// They are of different type (Trial vs TrialsCompanion) and
    /// the former users Value() so compare them.
    flutter_test.expect(obs.id.value, expId);
    flutter_test.expect(obs.participantId.value, exp.participantId.value);
    flutter_test.expect(obs.session.value, exp.session.value);
    flutter_test.expect(obs.stim.value, exp.stim.value);
    flutter_test.expect(obs.resp.value, exp.resp.value);
  });

  tearDown(() async {
    /// Not following recommended practice (see official drift tutorials) to
    /// await database closing because it caused the  test to hang
    database.close();
  });
}

connectionOpenerTest() => NativeDatabase.memory();
