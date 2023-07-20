import 'package:get/get.dart';
import 'package:data/db.dart';
import 'package:mspelling/login/login_controller.dart';
import 'package:mspelling/setup/setup_controller.dart';
import 'package:mspelling/activity/status.dart';
import 'package:mspelling/activity/stim_controller.dart';
import 'package:mspelling/errors/errors.dart';

/// Controls the task sequence
/// The sequence includes stim presentation, response, rest, end
class SpellingController extends GetxController {
  /// Provides access and manages the stimuli
  late final StimController _stimuli;

  /// Global task start time
  final DateTime _timeStart = DateTime.now();

  late final DataBase _database;

  /// Session  number for current participant
  late final int _sessionNumber;

  /// Identifies the step the task currently is in
  Step _status = Step.stim;

  /// Provides access to the participant ID
  final LoginController _loginController = Get.find();
  late final String _participantId;

  /// Provides access to the workspace
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

  /// Helper method to get the participant's session number from the db
  Future<void> _getSessionNumberParticipant() async {
    _sessionNumber =
        await _database.getCurrentParticipantSessionNumber(_participantId);
  }

  /// Add trial data to the db
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
    /// Update the current task step so the [run()] can continue the sequence
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

  /// Setup everything needed to start the task sequence
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

  /// Controls the task sequence based on the curren step
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
