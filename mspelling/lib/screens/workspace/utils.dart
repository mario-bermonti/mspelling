import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Let the user set the workspace
Future<void> setWorkspaceByUser() async {
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

  if (selectedDirectory != null) {
    /// TODO only call instance once
    SharedPreferences settings = await SharedPreferences.getInstance();
    settings.setString('workspace', selectedDirectory);
  } else {
    SharedPreferences settings = await SharedPreferences.getInstance();
    settings.remove('workspace');
  }
}

/// Get the workspace that will be used for accessing stim and saving data
Future<String?> getWorkspace() async {
  SharedPreferences settings = await SharedPreferences.getInstance();
  String? workSpace = settings.getString('workspace');
  return workSpace;
}

// Future<void> showDialogWorkspace() async {
//   await showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Área de trabajo'),
//           content:
//               const Text('Debes selecciona un área de trabajo para continuar'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Menú principal'),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginScreen()),
//                 );
//               },
//             ),
//             TextButton(
//               onPressed: () {
//                 setWorkspaceByUser;
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Selecctionar área de trabajo'),
//             )
//           ],
//         );
//       }).then((value) => Navigator.pop(context));
// }
