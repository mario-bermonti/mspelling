import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:mspelling/views/login_view.dart';
import 'package:mspelling/views/workspace_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Presents the workspace screen if no workspace is available,
/// otherwise presents the login screen
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
      Get.to(() => LoginView());
    } else {
      Get.to(() => WorkspaceView());
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
