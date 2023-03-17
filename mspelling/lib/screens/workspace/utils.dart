import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Let the user set the workspace
Future<void> setWorkspaceByUser() async {
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

  if (selectedDirectory != null) {
    /// TODO only call instance once
    SharedPreferences settings = await SharedPreferences.getInstance();
    settings.setString('workspace', selectedDirectory);
  }
}

/// Get the workspace that will be used for accessing stim and saving data
Future<String?> getWorkspace() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  String? workSpace = settings.getString('workspace');
  return workSpace;
}
