import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/data.dart';
import 'package:mspelling/screens/end.dart';
import 'package:mspelling/screens/rest.dart';
import 'package:mspelling/screens/spelling_activity/trial/trial_response_screen.dart';
import 'package:mspelling/screens/spelling_activity/trial/trial_stim_screen.dart';
import 'package:mspelling/stim.dart';

class SpellingScreen extends StatefulWidget {
  final String participantId;

  const SpellingScreen(this.participantId, {Key? key}) : super(key: key);

  @override
  State<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends State<SpellingScreen> {
  late final Stimuli _stimuli;
  bool _restActive = false;
  final DateTime timeStart = DateTime.now();
  final DataBase database = DataBase();
  late final int sessionNumber;

  @override
  initState() {
    super.initState();
    getStimuli();
    getSessionNumberParticipant();
    Future.delayed(const Duration(seconds: 1), () {
      run(context);
    });
  }

  void getSessionNumberParticipant() async {
    sessionNumber =
        await database.getCurrentParticipantSessionNumber(widget.participantId);
  }

  void run(context) {
    if (_stimuli.stimCountRemaining == 0) {
      endSession();
      return;
    }
    presentTrial(context);
    presentRestCond();
  }

  getStimuli() async {
    Stimuli stimuli =
        await createStimFromFile('assets/stimuli/stimuli_tests.txt');
    // await createStimFromFile('assets/stimuli/stimuli.txt');
    stimuli.randomize();
    _stimuli = stimuli;
  }

  void presentTrial(context) async {
    _stimuli.next();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrialStimScreen(stim: _stimuli.currentStim),
      ),
    );

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TrialResponseScreen(),
      ),
    );

    database.addTrialData(
      participantId: widget.participantId,
      stim: _stimuli.currentStim,
      resp: result,
      sessionNumber: sessionNumber,
    );
    Future.delayed(const Duration(seconds: 1), () {
      run(context);
    });
  }

  Future<void> presentRestCond() async {
    if (_restActive) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RestScreen(widget.participantId),
        ),
      );
    }
  }

  void endSession() {
    final DateTime timeEnd = DateTime.now();
    saveData(timeEnd: timeEnd);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EndScreen(),
      ),
    );
  }

  void saveData({required DateTime timeEnd}) {
    database.addSessionData(
        sessionNumber: sessionNumber,
        participantId: widget.participantId,
        timeStart: timeStart,
        timeEnd: timeEnd);
    database.addDeviceData(
      participantId: widget.participantId,
      sessionNumber: sessionNumber,
    );

    database.saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
        automaticallyImplyLeading: false,
      ),
      body: Container(),
    );
  }
}
