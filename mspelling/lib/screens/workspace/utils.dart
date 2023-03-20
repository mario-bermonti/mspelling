import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Let the user set the workspace and validate it
Future<void> setWorkspaceByUser() async {
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

  if (selectedDirectory != null) {
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
    throw Exception('The stim file was not found in workspace/stim');
  }
}
