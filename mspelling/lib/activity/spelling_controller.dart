import 'package:get/get.dart';
import 'package:data/db.dart';
import 'package:mspelling/login/login_controller.dart';
import 'package:mspelling/setup/setup_controller.dart';
import 'package:mspelling/activity/status.dart';
import 'package:mspelling/activity/stim_controller.dart';
import 'package:mspelling/errors/errors.dart';

// Controls the task's sequences
class SpellingController extends GetxController {
  // Stimuli used in the task
  late final StimController _stimuli;

  /// Global task start time
  final DateTime _timeStart = DateTime.now();
  late final DataBase _database;

  /// Session  number for current participant
  late final int _sessionNumber;

  Step _status = Step.stim;

  final LoginController _loginController = Get.find();
  late final String _participantId;

  final SetupController _setupController = Get.find();

  @override
  onInit() async {
    await _setup();
    super.onInit();
  }

  @override
  onReady() {
    run();
  }

  /// Helper method to get the session number for the current participant
  /// from the db
  Future<void> _getSessionNumberParticipant() async {
    _sessionNumber =
        await _database.getCurrentParticipantSessionNumber(_participantId);
  }

  /// Controls the sequence of the task, including presenting trials, rests,
  /// ITI, ending the session.
  /// [context] BuildContext: Needed to navigate
  void addTrialData({required String result}) {
    _database.addTrialData(
      participantId: _participantId,
      stim: _stimuli.stim.currentStim,
      resp: result,
      sessionNumber: _sessionNumber,
    );
  }

  // TODO improve name of conditions checks?
  /// TODO can presenting stim next be improved? Current implementation seems
  /// weird
  void _updateStatus() {
    if (_responseStatusFollows()) {
      _status = Step.response;
    } else if (_completedStatusFollows()) {
      _status = Step.completed;
    } else if (_stimStatusFollows()) {
      _status = Step.stim;
    } else if (_restStatusFollows()) {
      _status = Step.rest;
    } else {
      _status = Step.stim;
    }
  }

  bool _responseStatusFollows() => _status == Step.stim;
  bool _stimStatusFollows() => _status == Step.rest;
  bool _restStatusFollows() =>
      _stimuli.stim.stimCountUsed != 0 && _stimuli.stim.stimCountUsed % 5 == 0;
  bool _completedStatusFollows() => _stimuli.stim.stimCountRemaining == 0;

  void _endSession() {
    /// Global session end time
    final DateTime timeEnd = DateTime.now();

    _database.addSessionData(
        sessionNumber: _sessionNumber,
        participantId: _participantId,
        timeStart: _timeStart,
        timeEnd: timeEnd);
    _database.addDeviceData(
      participantId: _participantId,
      sessionNumber: _sessionNumber,
    );
    _database.saveData();
  }

  /// Get workspace, prepare stim, prepare db, and start spelling activity
  /// Throws error if the workspace is null (hasn't been set)
  Future<void> _setup() async {
    _participantId = _loginController.participantID;
    String? workspace = await _setupController.workspace;
    if (workspace == null) {
      throw WorkspaceAccessException();

      /// TODO check if this else is necessary
    } else {
      _stimuli = Get.put(StimController(stimPath: workspace));
      await _stimuli.prepareStim();
      _database = await getDB(path: '$workspace/mspelling_data.sqlite3');
    }
    await _getSessionNumberParticipant();
  }

  void run() {
    switch (_status) {
      case Step.stim:
        Get.toNamed('trialstim');
        _updateStatus();
        break;
      case Step.response:
        Get.toNamed('trialresponse');
        _updateStatus();
        break;
      case Step.rest:
        Get.toNamed('/rest');
        _updateStatus();
        break;
      case Step.completed:
        _endSession();
        Get.toNamed('end');
        return;
      default:
        run();
    }
  }
}
