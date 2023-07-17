import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/controllers/spelling_controller.dart';

class TrialResponseController extends GetxController {
  TextEditingController textController = TextEditingController();
  final SpellingController spellingController = Get.find();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void submit() {
    // spaces are meaningless as in paper and pencil measures
    String response = textController.text.trim();

    textController.clear();
    spellingController.addTrialData(result: response);
  }

  void toNextScreen() {
    spellingController.run();
  }
}
