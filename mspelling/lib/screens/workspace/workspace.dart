import 'package:flutter/material.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/screens/workspace/utils.dart';
import 'package:mspelling/setup_manager.dart';

import '../../components/default_appbar.dart';

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
          body: _buildUI(context),
        ));
  }

  CenteredBox _buildUI(BuildContext context) {
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
                    builder: (context) => const SetupManager(),
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
