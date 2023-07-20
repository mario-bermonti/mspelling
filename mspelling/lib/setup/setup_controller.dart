import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Setsup everything needed to start the app
/// Automatically presents the workspace screen if no workspace is available,
/// Otherwise presents the login screen
/// Manages the workspace
class SetupController extends GetxController {
  @override
  void onReady() {
    toNextScreen();
    super.onReady();
  }

  /// Get the workspace that will be used for accessing stim and saving data
  Future<String?> get workspace async {
    SharedPreferences settings = await SharedPreferences.getInstance();
    String? workSpace = settings.getString('workspace');
    return workSpace;
  }

  Future<void> toNextScreen() async {
    if (await workspace != null) {
      Get.toNamed('login');
    } else {
      Get.toNamed('workspace');
    }
  }

  /// Let the user set the workspace and validate it
  Future<void> setWorkspaceByUser() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      SharedPreferences settings = await SharedPreferences.getInstance();
      await settings.setString('workspace', selectedDirectory);
    }
  }
}
