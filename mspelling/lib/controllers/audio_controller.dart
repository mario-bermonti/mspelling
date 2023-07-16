import 'dart:io';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mspelling/errors.dart';
import 'package:mspelling/screens/errors.dart';

class AudioController extends GetxController {
  final AudioPlayer _audioplayer = AudioPlayer();

  /// Present from file audio
  Future<void> playAudio(String path) async {
    await _audioplayer.play(DeviceFileSource(path));
  }

  /// Validate the audio file exists
  Future<void> validateAudioStimFile(String path) async {
    File file = File(path);
    if (await file.exists() == false) {
      /// TODO should not know about the UI
      /// Should throw audio or other general exception
      Get.to(
        ErrorScreen(
          message:
              GenericMSpellingException('Error playing the audio stim file'),
        ),
      );
    }
  }
}