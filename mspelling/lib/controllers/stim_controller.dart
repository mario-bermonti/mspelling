import 'package:get/get.dart';
import 'package:mspelling/controllers/audio_controller.dart';
import 'package:mspelling/controllers/spelling_controller.dart';
import 'package:mspelling/errors.dart';
import 'package:stimuli/errors.dart';
import 'package:stimuli/stimuli.dart';

class StimController extends GetxController {
  late Stimuli stim;
  AudioController audioController = AudioController();
  String stimPath;

  StimController({required this.stimPath});

  @override
  void onInit() async {
    // TODO remove null operator when the workspace is fixed and can't be null
    await prepareStim();
    super.onInit();
  }

  /// Prepare stim to be used
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

  /// Present the stim once to the participant and go back
  Future<void> presentStim() async {
    String path = '$stimPath/stim/${stim.currentStim}.wav';
    await audioController.validateAudioStimFile(path);
    await audioController.playAudio(path);
  }
}
