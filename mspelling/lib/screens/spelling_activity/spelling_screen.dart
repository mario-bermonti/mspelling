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

class SpellingActivity extends StatefulWidget {
  // Controls the task's sequences
  // It has no ui representation

  final String participantId;

  const SpellingActivity(this.participantId, {Key? key}) : super(key: key);

  @override
  State<SpellingActivity> createState() => _SpellingActivityState();
}

class _SpellingActivityState extends State<SpellingActivity> {
  /// Stimuli used in the task
  late final Stimuli _stimuli;

  /// Global task start time
  final DateTime _timeStart = DateTime.now();
  final DataBase _database = DataBase();

  /// Session  number for current participant
  late final int _sessionNumber;

  @override
  initState() {
    super.initState();
    _prepareStimuli();
    _getSessionNumberParticipant();
    Future.delayed(const Duration(seconds: 1), () {
      _run(context); // for it to access context
    });
  }

  /// Helper method to get the session number for the current participant
  /// from the db
  void _getSessionNumberParticipant() async {
    _sessionNumber = await _database
        .getCurrentParticipantSessionNumber(widget.participantId);
  }

  Future<void> _run(context) async {
    /// Controls the sequence of the task, including presenting trials, rests,
    /// ITI, ending the session.

    await _presentTrial(context);

    // No more trials
    if (_stimuli.stimCountRemaining == 0) {
      _endSession();
      return;
    } else if (_stimuli.stimCountUsed != 0 && _stimuli.stimCountUsed % 5 == 0) {
      await _presentRest();
      _run(context);
    } else {
      /// ITI
      Future.delayed(const Duration(milliseconds: 500), () {
        _run(context);
      });
    }
  }

  /// Prepare stim to be used
  _prepareStimuli() async {
    Stimuli stimuli =
        await createStimFromFile('assets/stimuli/stimuli_tests.txt');
    // await createStimFromFile('assets/stimuli/stimuli.txt');
    stimuli.randomize();
    _stimuli = stimuli;
  }

  Future<void> _presentTrial(context) async {
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

    // TODO move to run method (not part of trial)
    _database.addTrialData(
      participantId: widget.participantId,
      stim: _stimuli.currentStim,
      resp: result,
      sessionNumber: _sessionNumber,
    );
  }

  // TODO Rename, not cond
  Future<void> _presentRest() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestScreen(widget.participantId),
      ),
    );
  }

  void _endSession() {
    /// Global session end time
    final DateTime timeEnd = DateTime.now();
    _saveData(timeEnd: timeEnd);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EndScreen(),
      ),
    );
  }

  void _saveData({required DateTime timeEnd}) {
    /// Save data to disk

    // TODO move to endSession method (not really saving)
    _database.addSessionData(
        sessionNumber: _sessionNumber,
        participantId: widget.participantId,
        timeStart: _timeStart,
        timeEnd: timeEnd);
    _database.addDeviceData(
      participantId: widget.participantId,
      sessionNumber: _sessionNumber,
    );

    _database.saveData();
  }

  @override
  Widget build(BuildContext context) {
    // Just a dummy function because we need(?) the Spelling screen to be a
    // widget for it to access context
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
        automaticallyImplyLeading: false,
      ),
      body: Container(),
    );
  }
}
