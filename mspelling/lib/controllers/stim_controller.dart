import 'dart:io';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mspelling/controllers/spelling_controller.dart';
import 'package:mspelling/errors.dart';
import 'package:mspelling/screens/errors.dart';

class TrialStimController extends GetxController {
  final SpellingController spellingController = Get.find();

  RxBool ready = RxBool(false);
  final AudioPlayer _audioplayer = AudioPlayer();
  // late DeviceFileSource _source;

  /// Present the stim once to the participant and go back
  Future<void> presentStim() async {
    String path =
        '${spellingController.workspace}/stim/${spellingController.stimuli.currentStim}.wav';
    await validateAudioStimFile(path);
    // _source = DeviceFileSource(path);
    await _audioplayer.play(DeviceFileSource(path));
    Future.delayed(const Duration(seconds: 1), () => spellingController.run());
    // .whenComplete(
    //       () => Future.delayed(
    //         const Duration(seconds: 1),
    //         () {
    //           Get.back();
    //         },
    //       ),
    //     );
  }

  /// Prepare the stim that will be presented
  /// Expects the stim to be in a dir named 'stim' in the workspace
  Future<void> prepareStim() async {
    ready = RxBool(false);
    String path =
        '${spellingController.workspace}/stim/${spellingController.stimuli.currentStim}.wav';
    await validateAudioStimFile(path);
    // _source = DeviceFileSource(path);
    await _audioplayer.setSourceDeviceFile(path);
    // ready(!ready.value);
    Future.delayed(const Duration(seconds: 5));
    ready = RxBool(true);
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
