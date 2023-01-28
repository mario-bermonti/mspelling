import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setWorkspaceByUser() async {
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

  if (selectedDirectory != null) {
    SharedPreferences settings = await SharedPreferences.getInstance();
    settings.setString('workspace', selectedDirectory);
  } else {
    SharedPreferences settings = await SharedPreferences.getInstance();
    settings.remove('workspace');
  }
}

Future<String?> getWorkspace() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  String? workSpace = settings.getString('workspace');
  return workSpace;
}
