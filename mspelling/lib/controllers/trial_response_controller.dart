import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/controllers/spelling_controller.dart';

class TrialResponseController extends GetxController {
  final TextEditingController _textController = TextEditingController();
  final SpellingController spellingController = Get.find();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void submit() {
    /// We assume leading or trailing whitespace do not impact response.
    /// Just like when writing using paper-and-pencil and there
    /// is trailling whitespace space
    String response = _textController.text.trim();
    spellingController.addTrialData(result: response);
  }

  void toNextScreen() {
    spellingController.run();
  }
}
