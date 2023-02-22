import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

Future<String?> getWorkspace() async {
  await Future.delayed(const Duration(seconds: 2));
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
