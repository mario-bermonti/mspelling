import 'package:get/get.dart';
import 'package:data/db.dart';
import 'package:mspelling/controllers/status.dart';
import 'package:mspelling/errors.dart';
import 'package:mspelling/screens/end.dart';
import 'package:mspelling/screens/rest.dart';
import 'package:mspelling/screens/spelling_activity/trial/trial_response_screen.dart';
import 'package:mspelling/screens/workspace/utils.dart';
import 'package:mspelling/views/trial_stim_view.dart';
import 'package:stimuli/errors.dart';
import 'package:stimuli/stimuli.dart';

// Controls the task's sequences
class SpellingController extends GetxController {
  final String participantId;

  SpellingController(this.participantId);

  /// Flag to indicate whether the ui can be displayed
  // late bool setupDone;

  /// Dir used to getting stim
  late String? workspace;

  /// Stimuli used in the task
  late final Stimuli stimuli;

  // late String response;

  /// Global task start time
  final DateTime _timeStart = DateTime.now();
  late final DataBase database;

  /// Session  number for current participant
  late final int sessionNumber;

  Status status = Status.stim;

  @override
  onInit() async {
    await setup();
    super.onInit();
  }

  @override
  onReady() {
    run();
  }

  /// Helper method to get the session number for the current participant
  /// from the db
  Future<void> _getSessionNumberParticipant() async {
    sessionNumber =
        await database.getCurrentParticipantSessionNumber(participantId);
  }

  /// Controls the sequence of the task, including presenting trials, rests,
  /// ITI, ending the session.
  /// [context] BuildContext: Needed to navigate
  void addTrialData({required String result}) {
    database.addTrialData(
      participantId: participantId,
      stim: stimuli.currentStim,
      resp: result,
      sessionNumber: sessionNumber,
    );
  }

  // TODO improve name of conditions checks?
  /// TODO can presenting stim next be improved? Current implementation seems
  /// weird
  void updateStatus() {
    if (responseStatusFollows()) {
      status = Status.response;
    } else if (completedStatusFollows()) {
      status = Status.completed;
    } else if (stimStatusFollows()) {
      status = Status.stim;
    } else if (restStatusFollows()) {
      status = Status.rest;
    } else {
      status = Status.stim;
    }
  }

  bool responseStatusFollows() => status == Status.stim;
  bool stimStatusFollows() => status == Status.rest;
  bool restStatusFollows() =>
      stimuli.stimCountUsed != 0 && stimuli.stimCountUsed % 5 == 0;
  bool completedStatusFollows() => stimuli.stimCountRemaining == 0;

  /// Prepare stim to be used
  Future<void> _prepareStimuli() async {
    String path = '$workspace/stim/stim.txt';
    try {
      Stimuli _stimuli = await createStimFromFile(path);
      _stimuli.randomize();
      stimuli = _stimuli;
    } on StimFileAccessException catch (e) {
      throw GenericMSpellingException(e.toString());
    }
  }

  void _endSession() {
    /// Global session end time
    final DateTime timeEnd = DateTime.now();

    database.addSessionData(
        sessionNumber: sessionNumber,
        participantId: participantId,
        timeStart: _timeStart,
        timeEnd: timeEnd);
    database.addDeviceData(
      participantId: participantId,
      sessionNumber: sessionNumber,
    );
    _saveData();
  }

  /// Save data to disk
  void _saveData() {
    database.saveData();
  }

  /// Get workspace, prepare stim, prepare db, and start spelling activity
  /// Throws error if the workspace is null (hasn't been set)
  Future<bool> setup() async {
    workspace = await getWorkspace();
    if (workspace == null) {
      throw WorkspaceAccessException();

      /// TODO check if this else is necessary
    } else {
      await _prepareStimuli();

      /// TODO handle errors
      database = await getDB(path: '$workspace/mspelling_data.sqlite3');
    }
    await _getSessionNumberParticipant();
    return true;
  }

  void run() {
    switch (status) {
      case Status.stim:
        stimuli.next();
        Get.to(() => TrialStimView());
        updateStatus();
        break;
      case Status.response:
        Get.to(const TrialResponseScreen());
        updateStatus();
        break;
      case Status.rest:
        Get.to(RestScreen(participantId));
        updateStatus();
        break;
      case Status.completed:
        _endSession();
        Get.to(const EndScreen());
        return;
      default:
        updateStatus();
        run();
    }
  }
}
