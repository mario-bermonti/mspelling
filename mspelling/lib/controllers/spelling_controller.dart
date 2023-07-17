import 'package:get/get.dart';
import 'package:data/db.dart';
import 'package:mspelling/controllers/login_controller.dart';
import 'package:mspelling/controllers/setup_controller.dart';
import 'package:mspelling/controllers/status.dart';
import 'package:mspelling/controllers/stim_controller.dart';
import 'package:mspelling/errors.dart';
import 'package:mspelling/views/end_view.dart';
import 'package:mspelling/views/rest_view.dart';
import 'package:mspelling/views/trial_response_view.dart';
import 'package:mspelling/views/trial_stim_view.dart';

// Controls the task's sequences
class SpellingController extends GetxController {
  // Stimuli used in the task
  late final StimController stimuli;

  /// Global task start time
  final DateTime _timeStart = DateTime.now();
  late final DataBase database;

  /// Session  number for current participant
  late final int sessionNumber;

  Step status = Step.stim;

  final LoginController loginController = Get.find();
  late final String participantId;

  final SetupController setupController = Get.find();

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
      stim: stimuli.stim.currentStim,
      resp: result,
      sessionNumber: sessionNumber,
    );
  }

  // TODO improve name of conditions checks?
  /// TODO can presenting stim next be improved? Current implementation seems
  /// weird
  void updateStatus() {
    if (responseStatusFollows()) {
      status = Step.response;
    } else if (completedStatusFollows()) {
      status = Step.completed;
    } else if (stimStatusFollows()) {
      status = Step.stim;
    } else if (restStatusFollows()) {
      status = Step.rest;
    } else {
      status = Step.stim;
    }
  }

  bool responseStatusFollows() => status == Step.stim;
  bool stimStatusFollows() => status == Step.rest;
  bool restStatusFollows() =>
      stimuli.stim.stimCountUsed != 0 && stimuli.stim.stimCountUsed % 5 == 0;
  bool completedStatusFollows() => stimuli.stim.stimCountRemaining == 0;

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
    database.saveData();
  }

  /// Get workspace, prepare stim, prepare db, and start spelling activity
  /// Throws error if the workspace is null (hasn't been set)
  Future<void> setup() async {
    participantId = loginController.participantID;
    String? workspace = await setupController.workspace;
    if (workspace == null) {
      throw WorkspaceAccessException();

      /// TODO check if this else is necessary
    } else {
      stimuli = Get.put(StimController(stimPath: workspace));
      await stimuli.prepareStim();
      database = await getDB(path: '$workspace/mspelling_data.sqlite3');
    }
    await _getSessionNumberParticipant();
  }

  void run() {
    switch (status) {
      case Step.stim:
        Get.to(() => TrialStimView());
        updateStatus();
        break;
      case Step.response:
        Get.to(() => TrialResponseView());
        updateStatus();
        break;
      case Step.rest:
        Get.to(() => RestView());
        updateStatus();
        break;
      case Step.completed:
        _endSession();
        Get.to(() => const EndView());
        return;
      default:
        run();
    }
  }
}
