import 'package:get/get.dart';
import 'package:mspelling/controllers/audio_controller.dart';
import 'package:mspelling/controllers/spelling_controller.dart';
import 'package:mspelling/errors.dart';
import 'package:stimuli/errors.dart';
import 'package:stimuli/stimuli.dart';

class StimController extends GetxController {
  late Stimuli stim;
  AudioController audioController = AudioController();
  SpellingController spellingController = Get.find();
  late String pathStim;

  @override
  void onInit() async {
    pathStim = spellingController.workspace!;
    await prepareStimuli();
    // TODO remove null operator when the workspace is fixed and can't be null
    super.onInit();
  }

  /// Prepare stim to be used
  Future<void> prepareStimuli() async {
    try {
      Stimuli stimuli = await createStimFromFile(pathStim);
      stimuli.randomize();
      stim = stimuli;
    } on StimFileAccessException catch (e) {
      throw GenericMSpellingException(e.toString());
    }
  }

  /// Present the stim once to the participant and go back
  Future<void> presentStimuli() async {
    String path = '$pathStim/${stim.currentStim}.wav';
    await audioController.validateAudioStimFile(path);
    await audioController.playAudio(path);
  }
}
