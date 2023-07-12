import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/screens/login.dart';
import 'package:mspelling/views/workspace_view.dart';

createAppBar({required BuildContext context, bool showActionButtons = false}) {
  return AppBar(
      title: const Text(appBarTitle),
      automaticallyImplyLeading: false,
      centerTitle: true,
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
            builder: (context) => const LoginScreen(),
          ),
        );
      },
    ),
    IconButton(
      icon: const Icon(Icons.settings),
      tooltip: 'Directorio de trabajo',
      onPressed: () => Get.to(() => WorkspaceView()),
    ),
  ];
  return actionButtons;
}
