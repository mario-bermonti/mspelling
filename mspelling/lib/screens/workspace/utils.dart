import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

/// Let the user set the workspace and validate it
Future<void> setWorkspaceByUser() async {
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

  if (selectedDirectory != null) {
    await getPermissionIfNecessary(selectedDirectory);
    await validate(selectedDirectory);
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

/// Validate the workspace selected by the user
Future<void> validate(String workspace) async {
  String stimFile = '$workspace/stim/stim.txt';
  bool result = await File(stimFile).exists();

  if (result == false) {
    throw Exception(
        'The stim file was not found within the workspoace in a directory named stim');
  }
}

/// Get permission to use the path provided if necessary
/// Throws error if permission is needed and not granted
/// [path] String path where to access the workspace
Future<void> getPermissionIfNecessary(String path) async {
  if (Platform.isAndroid) {
    bool granted = await Permission.storage.request().isGranted;
    if (!granted) {
      throw Exception(
          'Permission for accessing the specified workspace was requested but not granted');
    }
  }
}
