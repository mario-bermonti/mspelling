import 'package:flutter/material.dart';
import 'package:mspelling/screens/login.dart';
import 'package:mspelling/screens/workspace/utils.dart';
import 'package:mspelling/screens/workspace/workspace.dart';
import 'package:mspelling/styles.dart';

class MSpelling extends StatefulWidget {
  const MSpelling({Key? key}) : super(key: key);

  @override
  State<MSpelling> createState() => _MSpellingState();
}

class _MSpellingState extends State<MSpelling> {
  late Future<String?> _workspaceSet;

  @override
  void initState() {
    setState(() {
      _workspaceSet = getWorkspace();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _workspaceSet,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text("Error");
          } else if (snapshot.data == null) {
            return MaterialApp(
              title: 'mSpelling',
              theme: themeData,
              home: const SetWorkspaceScreen(),
            );
          } else {
            return MaterialApp(
              title: 'mSpelling',
              theme: themeData,
              home: const LoginScreen(),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
