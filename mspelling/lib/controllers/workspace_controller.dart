import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:mspelling/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkspaceController extends GetxController {
  /// Let the user set the workspace and validate it
  Future<void> setWorkspaceByUser() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      SharedPreferences settings = await SharedPreferences.getInstance();
      await settings.setString('workspace', selectedDirectory);
    }
  }

  /// Get the workspace that will be used for accessing stim and saving data
  Future<String?> getWorkspace() async {
    SharedPreferences settings = await SharedPreferences.getInstance();
    String? workSpace = settings.getString('workspace');
    return workSpace;
  }

  void nextScreen() {
    Get.to(LoginView());
  }
}
