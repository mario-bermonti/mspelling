import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/views/begin_view.dart';

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
    Get.to(const BeginView());
  }
}
