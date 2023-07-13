import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/screens/begin_message.dart';

class LoginController extends GetxController {
  final TextEditingController controller = TextEditingController();
  late final String participantID;

  @override
  void onClose() {
    controller.dispose();
    super.dispose();
  }

  void gotoBeginScreen(participantID) {
    participantID = controller.text.trim(); // spaces are meaningless in ids.
    Get.to(BeginScreen(participantID));
  }
}
