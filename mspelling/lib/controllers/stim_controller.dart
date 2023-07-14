import 'dart:io';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mspelling/controllers/spelling_controller.dart';
import 'package:mspelling/errors.dart';
import 'package:mspelling/screens/errors.dart';

class StimController extends GetxController {
  final SpellingController spellingController = Get.find();

  RxBool ready = RxBool(false);
  final AudioPlayer _audioplayer = AudioPlayer();

  /// Present the stim once to the participant and go back
  Future<void> presentStim() async {
    String path =
        '${spellingController.workspace}/stim/${spellingController.stimuli.currentStim}.wav';
    await validateAudioStimFile(path);
    await _audioplayer.play(DeviceFileSource(path));
    Future.delayed(const Duration(seconds: 1), () => spellingController.run());
  }

  /// Validate the audio stim file exists
  Future<void> validateAudioStimFile(String path) async {
    File file = File(path);
    if (await file.exists() == false) {
      Get.to(
        ErrorScreen(
          message:
              GenericMSpellingException('Error playing the audio stim file'),
        ),
      );
    }
  }
}
