import 'package:get/get.dart';
import 'package:mspelling/controllers/audio_controller.dart';
import 'package:mspelling/controllers/spelling_controller.dart';
import 'package:mspelling/errors.dart';
import 'package:stimuli/errors.dart';
import 'package:stimuli/stimuli.dart';

class StimController extends GetxController {
  late Stimuli stim;
  final AudioController _audioController = AudioController();
  String stimPath;

  StimController({required this.stimPath});

  @override
  void onInit() async {
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
