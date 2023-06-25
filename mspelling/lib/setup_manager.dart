import 'package:flutter/material.dart';
import 'package:mspelling/screens/login.dart';
import 'package:mspelling/screens/workspace/utils.dart';
import 'package:mspelling/screens/workspace/workspace.dart';

class SetupManager extends StatefulWidget {
  const SetupManager({Key? key}) : super(key: key);

  @override
  State<SetupManager> createState() => _SetupManagerState();
}

class _SetupManagerState extends State<SetupManager> {
  /// Presents the workspace screen if no workspace is available,
  /// otherwise presents the login screen
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWorkspace(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text("Error");
          } else {
            if (snapshot.data == null) {
              return const SetWorkspaceScreen();
            } else {
              return const LoginScreen();
            }
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
