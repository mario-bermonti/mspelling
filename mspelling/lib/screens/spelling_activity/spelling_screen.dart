import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:data/db.dart';
import 'package:mspelling/screens/end.dart';
import 'package:mspelling/screens/rest.dart';
import 'package:mspelling/screens/spelling_activity/trial/trial_response_screen.dart';
import 'package:mspelling/screens/spelling_activity/trial/trial_stim_screen.dart';
import 'package:mspelling/screens/workspace/utils.dart';
import 'package:stimuli/stimuli.dart';

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

  late String? _workspace;
  late Future<bool> setupDone;

  @override
  initState() {
    super.initState();
    setupDone = setup();
  }

  /// Helper method to get the session number for the current participant
  /// from the db
  Future<void> _getSessionNumberParticipant() async {
    _sessionNumber = await _database
        .getCurrentParticipantSessionNumber(widget.participantId);
  }

  Future<void> _run(context) async {
    /// Controls the sequence of the task, including presenting trials, rests,
    /// ITI, ending the session.

    final String result = await _presentTrial(context);
    _database.addTrialData(
      participantId: widget.participantId,
      stim: _stimuli.currentStim,
      resp: result,
      sessionNumber: _sessionNumber,
    );

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
  Future<void> _prepareStimuli() async {
    String path = '$_workspace/stim/stim.txt';
    Stimuli stimuli = await createStimFromFile(path);
    stimuli.randomize();
    _stimuli = stimuli;
  }

  /// Get workspace path for current session
  /// Returns workspace for demo version if no workspace has been selected.
  /// Otherwise returns the path selected by the user.
  // Future<void> setWorkspaceCurrentSession() async {
  //   String? workSpace = await getWorkspace();
  //   if (workSpace == null) {
  //     await showDialogWorkspace(context: context);
  //     // workSpace = await getWorkspace();
  //     await setWorkspaceCurrentSession();
  //   }
  //   _workspace = workSpace!;
  // }

  Future<String> _presentTrial(context) async {
    _stimuli.next();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrialStimScreen(stim: _stimuli.currentStim),
      ),
    );

    final String result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TrialResponseScreen(),
      ),
    );

    return result;
  }

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

    _database.addSessionData(
        sessionNumber: _sessionNumber,
        participantId: widget.participantId,
        timeStart: _timeStart,
        timeEnd: timeEnd);
    _database.addDeviceData(
      participantId: widget.participantId,
      sessionNumber: _sessionNumber,
    );
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

    _database.saveData();
  }

  @override
  Widget build(BuildContext context) {
    // Just a dummy function because we need(?) the Spelling screen to be a
    // widget for it to access context
    return FutureBuilder(
        future: setupDone,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text("Error");
            } else {
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text(appBarTitle),
                    automaticallyImplyLeading: false,
                  ),
                  body: Container(),
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<bool> setup() async {
    _workspace = await getWorkspace();
    await _prepareStimuli();
    await _getSessionNumberParticipant();
    // TODO find a better way to handle navigation
    // Don't pass context around
    _run(context); // for it to access context
    return true;
  }
}
