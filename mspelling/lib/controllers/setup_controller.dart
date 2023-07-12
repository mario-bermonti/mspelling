import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/screens/login.dart';
import 'package:mspelling/screens/workspace/utils.dart';
import 'package:mspelling/screens/workspace/workspace.dart';

/// Presents the workspace screen if no workspace is available,
/// otherwise presents the login screen
class SetupController extends GetxController {
  late String? _workspace;

  @override
  Future<void> onInit() async {
    _workspace = await getWorkspace();
    super.onInit();
  }

  @override
  void onReady() {
    toNextScreen();
    super.onReady();
  }

  void toNextScreen() {
    if (_workspace != null) {
      Get.to(const LoginScreen());
    } else {
      Get.to(const SetWorkspaceScreen());
    }
  }
}
