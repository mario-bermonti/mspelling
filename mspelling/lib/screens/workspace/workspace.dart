import 'package:flutter/material.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/screens/login.dart';
import 'package:mspelling/screens/workspace/utils.dart';
import 'package:mspelling/components/default_appbar.dart';

class SetWorkspaceScreen extends StatefulWidget {
  const SetWorkspaceScreen({Key? key}) : super(key: key);

  @override
  State<SetWorkspaceScreen> createState() => _SetWorkspaceScreenState();
}

class _SetWorkspaceScreenState extends State<SetWorkspaceScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: createAppBar(context: context),
          body: const WorkspaceBody(),
        ));
  }
}

class WorkspaceBody extends StatelessWidget {
  const WorkspaceBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CenteredBox(
      column: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              setWorkspaceByUser().then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                ),
              );
            },
            child: const DefaultText(text: 'Selecciona área de trabajo'),
          ),
        ],
      ),
    );
  }
}
