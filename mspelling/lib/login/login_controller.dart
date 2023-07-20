import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Manager that holds the participant ID
class LoginController extends GetxController {
  final TextEditingController textController = TextEditingController();
  late final String participantID;

  @override
  void onClose() {
    textController.dispose();
    super.dispose();
  }

  void submitParticipantID() {
    participantID =
        textController.text.trim(); // spaces are meaningless in ids.
  }

  void toNextScreen() {
    Get.toNamed('/begin');
  }
}
