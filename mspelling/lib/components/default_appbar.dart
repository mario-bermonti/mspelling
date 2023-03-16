import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/screens/workspace/utils.dart';
import 'package:mspelling/setup_manager.dart';

createAppBar({required BuildContext context, bool showActionButtons = false}) {
  return AppBar(
      title: const Text(appBarTitle),
      automaticallyImplyLeading: false,
      actions:
          showActionButtons ? createActionButtons(context: context) : null);
}

List<Widget> createActionButtons({required BuildContext context}) {
  List<Widget> actionButtons = <Widget>[
    IconButton(
      icon: const Icon(Icons.home),
      tooltip: 'Inicio',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SetupManager(),
          ),
        );
      },
    ),
    const IconButton(
      icon: Icon(Icons.settings),
      tooltip: 'Directorio de trabajo',
      onPressed: setWorkspaceByUser,
    ),
  ];
  return actionButtons;
}
