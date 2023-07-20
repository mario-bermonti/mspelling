import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/common/constants.dart';

/// Custom app bar that shows that can show predefined action buttons
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
      onPressed: (() => Get.toNamed('/login')),
    ),
    IconButton(
      icon: const Icon(Icons.settings),
      tooltip: 'Directorio de trabajo',
      onPressed: () => Get.toNamed('workspace'),
    ),
  ];
  return actionButtons;
}
