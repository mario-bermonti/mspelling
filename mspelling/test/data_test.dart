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

  flutter_test.testWidgets('save many trials to database', (tester) async {
    // set up

    // trial 1
    var exp1 = const TrialsCompanion(
      participantId: Value('001'),
      stim: Value('gato'),
      resp: Value('gato'),
      session: Value(1),
    );

    // trial 2
    var exp2 = const TrialsCompanion(
      participantId: Value('002'),
      stim: Value('perro'),
      resp: Value('perros'),
      session: Value(2),
    );

    database.trialsData.addAll([exp1, exp2]);
    database.insertTrials();

    // obs
    List<Trial> obs = await database.getTrials();

    // checks
    // trial 1
    flutter_test.expect(
      obs[0].participantId,
      exp1.participantId.value,
    );
    flutter_test.expect(
      obs[0].session,
      exp1.session.value,
    );
    flutter_test.expect(
      obs[0].stim,
      exp1.stim.value,
    );
    flutter_test.expect(
      obs[0].resp,
      exp1.resp.value,
    );
    // trial 2
    flutter_test.expect(
      obs[1].participantId,
      exp2.participantId.value,
    );
    flutter_test.expect(
      obs[1].session,
      exp2.session.value,
    );
    flutter_test.expect(
      obs[1].stim,
      exp2.stim.value,
    );
    flutter_test.expect(
      obs[1].resp,
      exp2.resp.value,
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

  flutter_test.testWidgets('add data to data manager - single trial',
      (tester) async {
    // set up
    var exp = const TrialsCompanion(
      participantId: Value('001'),
      stim: Value('gato'),
      resp: Value('gato'),
      session: Value(1),
    );

    database.addTrialData(
      participantId: exp.participantId.value,
      stim: exp.stim.value,
      resp: exp.resp.value,
      session: exp.session.value,
    );

    TrialsCompanion obs = database.trialsData[0];

    flutter_test.expect(obs, exp);
  });
  flutter_test.testWidgets('add data to data manager - many trials',
      (tester) async {
    // set up
    // trial 1
    var exp1 = const TrialsCompanion(
      participantId: Value('001'),
      stim: Value('gato'),
      resp: Value('gato'),
      session: Value(1),
    );

    database.addTrialData(
      participantId: exp1.participantId.value,
      stim: exp1.stim.value,
      resp: exp1.resp.value,
      session: exp1.session.value,
    );

    TrialsCompanion obs1 = database.trialsData[0];
    flutter_test.expect(obs1, exp1);

    // trial 2
    var exp2 = const TrialsCompanion(
      participantId: Value('002'),
      stim: Value('perro'),
      resp: Value('perros'),
      session: Value(2),
    );

    database.addTrialData(
      participantId: exp2.participantId.value,
      stim: exp2.stim.value,
      resp: exp2.resp.value,
      session: exp2.session.value,
    );

    TrialsCompanion obs2 = database.trialsData[1];
    flutter_test.expect(obs2, exp2);
  });
}

connectionOpenerTest() => NativeDatabase.memory(logStatements: true);
