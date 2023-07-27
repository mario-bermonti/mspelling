import 'package:get/get.dart';
import 'package:mspelling/activity/audio_controller.dart';
import 'package:mspelling/activity/spelling_controller.dart';
import 'package:mspelling/errors/errors.dart';
import 'package:stimuli/errors.dart';
import 'package:stimuli/stimuli.dart';

/// Manage the stim
class StimController extends GetxController {
  late Stimuli stim;
  final AudioController _audioController = AudioController();
  String stimPath;

  StimController({required this.stimPath});

  @override
  void onInit() async {
    super.onInit();
  }

  /// Prepare stim to be used
  /// Includes building from file, create object, and randomize stim
  Future<void> prepareStim() async {
    String path = '$stimPath/stim/stim.txt';
    try {
      Stimuli stimuli = await createStimFromFile(path);
      stimuli.randomize();
      stim = stimuli;
    } on StimFileAccessException catch (e) {
      throw GenericMSpellingException(e.toString());
    }
  }

  /// Present the stim once to the participant and go back after 1s ISI
  Future<void> presentStim() async {
    String path = '$stimPath/stim/${stim.currentStim}.wav';
    await _audioController.validateAudioStimFile(path);
    await _audioController.playAudio(path);
    SpellingController spellingController = Get.find();
    // TODO move to a better place
    Future.delayed(
      const Duration(seconds: 1),
      () => spellingController.run(),
    );
  }
}
