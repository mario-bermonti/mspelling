import 'package:flutter/material.dart';
import 'package:mspelling/components/default_appbar.dart';
import 'package:data/db.dart';
import 'package:mspelling/errors.dart';
import 'package:mspelling/screens/end.dart';
import 'package:mspelling/screens/errors.dart';
import 'package:mspelling/screens/rest.dart';
import 'package:mspelling/screens/spelling_activity/trial/trial_response_screen.dart';
import 'package:mspelling/screens/spelling_activity/trial/trial_stim_screen.dart';
import 'package:mspelling/screens/workspace/utils.dart';
import 'package:stimuli/stimuli.dart';

// Controls the task's sequences
// It has no ui representation
class SpellingActivity extends StatefulWidget {
  final String participantId;

  const SpellingActivity(this.participantId, {Key? key}) : super(key: key);

  @override
  State<SpellingActivity> createState() => _SpellingActivityState();
}

class _SpellingActivityState extends State<SpellingActivity> {
  /// Flag to indicate whether the ui can be displayed
  late Future<bool> setupDone;

  /// Dir used to getting stim
  late String? _workspace;

  /// Stimuli used in the task
  late final Stimuli _stimuli;

  /// Global task start time
  final DateTime _timeStart = DateTime.now();
  late final DataBase _database;

  /// Session  number for current participant
  late final int _sessionNumber;

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

  /// Controls the sequence of the task, including presenting trials, rests,
  /// ITI, ending the session.
  /// [context] BuildContext: Needed to navigate
  Future<void> _run(context) async {
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

  /// [context] BuildContext: Needed to navigate
  Future<String> _presentTrial(context) async {
    _stimuli.next();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TrialStimScreen(workspace: _workspace!, stim: _stimuli.currentStim),
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
    _saveData();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EndScreen(),
      ),
    );
  }

  /// Save data to disk
  void _saveData() {
    _database.saveData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: setupDone,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return ErrorScreen(message: snapshot.error.toString());
            } else {
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: Scaffold(
                  appBar: createAppBar(context: context),
                  // Just a dummy function because we need(?) the Spelling
                  // screen to be a widget
                  body: Container(),
                ),
              );
            }
          } else {
            return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  /// Get workspace, prepare stim, prepare db, and start spelling activity
  /// Throws error if the workspace is null (hasn't been set)
  Future<bool> setup() async {
    _workspace = await getWorkspace();
    if (_workspace == null) {
      throw WorkspaceAccessException();

      /// TODO check if this else is necessary
    } else {
      await _prepareStimuli();

      /// TODO handle errors
      _database = await getDB(path: '$_workspace/mspelling_data.sqlite3');
    }
    await _getSessionNumberParticipant();
    // TODO find a better way to handle navigation
    // Don't pass context around
    _run(context); // for it to access context
    return true;
  }
}
