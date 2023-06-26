import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:data/db.dart';
import 'package:mspelling/controllers/status.dart';
import 'package:mspelling/errors.dart';
import 'package:mspelling/screens/workspace/utils.dart';
import 'package:stimuli/errors.dart';
import 'package:stimuli/stimuli.dart';

// Controls the task's sequences
class SpellingController extends GetxController {
  final String participantId;

  SpellingController(this.participantId);

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

  Status status = Status.stim;

  @override
  onInit() {
    super.onInit();
    setupDone = setup();
  }

  /// Helper method to get the session number for the current participant
  /// from the db
  Future<void> _getSessionNumberParticipant() async {
    _sessionNumber =
        await _database.getCurrentParticipantSessionNumber(participantId);
  }

  /// Controls the sequence of the task, including presenting trials, rests,
  /// ITI, ending the session.
  /// [context] BuildContext: Needed to navigate
  void addTrialData({required String result}) {
    _database.addTrialData(
      participantId: participantId,
      stim: _stimuli.currentStim,
      resp: result,
      sessionNumber: _sessionNumber,
    );
  }

  void updateActivity() {
    _stimuli.next();
    updateStatus();
  }

  void updateStatus() {
    if (responseStatusFollows()) {
      status = Status.response;
    } else if (restStatusFollows()) {
      status = Status.rest;
    } else if (completedStatusFollows()) {
      status = Status.completed;
    } else {
      status = Status.stim;
    }
  }

  bool responseStatusFollows() => status == Status.stim;
  bool restStatusFollows() =>
      _stimuli.stimCountUsed != 0 && _stimuli.stimCountUsed % 5 == 0;
  bool completedStatusFollows() => _stimuli.stimCountRemaining == 0;

  /// Prepare stim to be used
  Future<void> _prepareStimuli() async {
    String path = '$_workspace/stim/stim.txt';
    try {
      Stimuli stimuli = await createStimFromFile(path);
      stimuli.randomize();
      _stimuli = stimuli;
    } on StimFileAccessException catch (e) {
      throw GenericMSpellingException(e.toString());
    }
  }

  void _endSession() {
    /// Global session end time
    final DateTime timeEnd = DateTime.now();

    _database.addSessionData(
        sessionNumber: _sessionNumber,
        participantId: participantId,
        timeStart: _timeStart,
        timeEnd: timeEnd);
    _database.addDeviceData(
      participantId: participantId,
      sessionNumber: _sessionNumber,
    );
    _saveData();
  }

  /// Save data to disk
  void _saveData() {
    _database.saveData();
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
    return true;
  }
}
