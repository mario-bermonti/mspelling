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
    flutter_test.expect(
      obs.id.value,
      expId,
    );
    flutter_test.expect(
      obs.participantId.value,
      exp.participantId.value,
    );
    flutter_test.expect(
      obs.session.value,
      exp.session.value,
    );
    flutter_test.expect(
      obs.stim.value,
      exp.stim.value,
    );
    flutter_test.expect(
      obs.resp.value,
      exp.resp.value,
    );
  });

  flutter_test.testWidgets('save session to database', (tester) async {
    /// exp
    var exp = SessionsCompanion(
      sessionNumberParticipant: const Value(1),
      participantId: const Value('001'),
      timeStart: Value(DateTime.now()),
      timeEnd: Value(DateTime.now()),
    );
    final int expId = await database.insertSession(exp);

    /// obs
    final sessionDatabase = await database.getSession(expId);
    final SessionsCompanion obs = sessionDatabase.toCompanion(true);

    /// checks
    /// TODO Check if there is a simpler way to compare them
    /// They are of different type (session vs SessionsCompanion) and
    /// the former users Value() so compare them.
    flutter_test.expect(obs.id.value, expId);
    flutter_test.expect(
      obs.participantId.value,
      exp.participantId.value,
    );
    flutter_test.expect(
      obs.sessionNumberParticipant.value,
      exp.sessionNumberParticipant.value,
    );

    /// TimeStart
    /// needs to be converted, to limit precision (different seconds)
    final DateTime expTimeStartShorten = DateTime(
      obs.timeStart.value.year,
      exp.timeStart.value.month,
      obs.timeStart.value.day,
    );
    final DateTime obsTimeStartShorten = DateTime(
      obs.timeStart.value.year,
      obs.timeStart.value.month,
      obs.timeStart.value.day,
    );
    flutter_test.expect(
      obsTimeStartShorten,
      expTimeStartShorten,
    );

    /// TimeEnd
    /// needs to be converted, to limit precision (different seconds)
    final DateTime expTimeEndShorten = DateTime(
      obs.timeEnd.value.year,
      exp.timeEnd.value.month,
      obs.timeEnd.value.day,
    );
    final DateTime obsTimeEndShorten = DateTime(
      obs.timeEnd.value.year,
      obs.timeEnd.value.month,
      obs.timeEnd.value.day,
    );
    flutter_test.expect(
      obsTimeEndShorten,
      expTimeEndShorten,
    );
  });

  flutter_test.testWidgets('save single device to database', (tester) async {
    /// exp
    var exp = const DevicesCompanion(
      participantId: Value('001'),
      session: Value(1),
    );
    final int expId = await database.insertDevice(exp);

    /// obs
    final deviceDatabase = await database.getDevice(expId);
    final DevicesCompanion obs = deviceDatabase.toCompanion(true);

    /// checks
    /// TODO Check if there is a simpler way to compare them
    /// They are of different type (Trial vs TrialsCompanion) and
    /// the former users Value() so compare them.
    ///
    ///
    /// Only 'static' attrs are tested, because dynamic attrs are absent at
    /// creation
    flutter_test.expect(
      obs.id.value,
      expId,
    );
    flutter_test.expect(
      obs.participantId.value,
      exp.participantId.value,
    );
    flutter_test.expect(
      obs.session.value,
      exp.session.value,
    );
  });

  flutter_test.testWidgets('get current session id - first session',
      (tester) async {
    const int exp = 1;
    final int obs = await database.getCurrentParticipantSessionNumber('001');
    flutter_test.expect(obs, exp);
  });

  /// TODO use max value instead or rethink this
  flutter_test.testWidgets('get current session id - second session',
      (tester) async {
    const int exp = 2;
    const participantId = '001';

    /// create previous sessions for user
    var session = SessionsCompanion(
      sessionNumberParticipant: const Value(1),
      participantId: const Value(participantId),
      timeStart: Value(DateTime.now()),
      timeEnd: Value(DateTime.now()),
    );
    await database.insertSession(session);

    /// obs
    final int obs =
        await database.getCurrentParticipantSessionNumber(participantId);

    /// check
    flutter_test.expect(obs, exp);
  });

  flutter_test.testWidgets('get current session id - 3+ session',
      (tester) async {
    const int exp = 3;
    const participantId = '001';

    /// create previous sessions for user
    var session1 = SessionsCompanion(
      sessionNumberParticipant: const Value(1),
      participantId: const Value(participantId),
      timeStart: Value(DateTime.now()),
      timeEnd: Value(DateTime.now()),
    );
    await database.insertSession(session1);

    var session2 = SessionsCompanion(
      sessionNumberParticipant: const Value(2),
      participantId: const Value(participantId),
      timeStart: Value(DateTime.now()),
      timeEnd: Value(DateTime.now()),
    );
    await database.insertSession(session2);

    /// obs
    final int obs =
        await database.getCurrentParticipantSessionNumber(participantId);

    /// check
    flutter_test.expect(obs, exp);
  });

  tearDown(() async {
    /// Not following recommended practice (see official drift tutorials) to
    /// await database closing because it caused the  test to hang
    database.close();
  });
  flutter_test.testWidgets('add data to data manager - session ',
      (tester) async {
    // set up
    var exp = SessionsCompanion(
      sessionNumberParticipant: const Value(1),
      participantId: const Value('001'),
      timeStart: Value(DateTime.now()),
      timeEnd: Value(DateTime.now()),
    );

    database.addSessionData(
      sessionNumberParticipant: exp.sessionNumberParticipant.value,
      participantId: exp.participantId.value,
      timeStart: exp.timeStart.value,
      timeEnd: exp.timeEnd.value,
    );

    SessionsCompanion obs = database.sessionData;

    flutter_test.expect(obs, exp);
  });
  flutter_test.testWidgets('add data to data manager - device ',
      (tester) async {
    // set up
    var exp = const DevicesCompanion(
      participantId: Value('001'),
      session: Value(1),
    );

    database.addDeviceData(
      participantId: exp.participantId.value,
      session: exp.session.value,
    );

    DevicesCompanion obs = database.deviceData;

    flutter_test.expect(obs, exp);
  });
}

connectionOpenerTest() => NativeDatabase.memory(logStatements: true);
