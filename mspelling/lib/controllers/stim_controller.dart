import 'dart:io';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mspelling/controllers/spelling_controller.dart';
import 'package:mspelling/errors.dart';
import 'package:mspelling/screens/errors.dart';
import 'package:stimuli/errors.dart';
import 'package:stimuli/stim.dart';
import 'package:stimuli/stimuli.dart';

class StimController extends GetxController {
  String path;
  late Stimuli stim;

  StimController(this.path);

  @override
  void onInit() async {
    await prepareStimuli();
    super.onInit();
  }

  /// Prepare stim to be used
  Future<void> prepareStimuli() async {
    try {
      Stimuli stimuli = await createStimFromFile(path);
      stimuli.randomize();
      stim = stimuli;
    } on StimFileAccessException catch (e) {
      throw GenericMSpellingException(e.toString());
    }
  }
}
