import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/screens/workspace/utils.dart';

createAppBar({bool showWorkspaceButton = false}) {
  return AppBar(
      title: const Text(appBarTitle),
      automaticallyImplyLeading: false,
      actions: showWorkspaceButton ? workspaceButton : null);
}

const List<Widget> workspaceButton = <Widget>[
  IconButton(
    icon: Icon(Icons.settings),
    tooltip: 'Directorio de trabajo',
    onPressed: setWorkspaceByUser,
  ),
];
