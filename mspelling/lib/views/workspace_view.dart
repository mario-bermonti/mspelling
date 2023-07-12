import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/controllers/workspace_controller.dart';
import 'package:mspelling/components/default_appbar.dart';

class WorkspaceView extends StatelessWidget {
  WorkspaceView({super.key});

  final WorkspaceController workspaceController =
      Get.put(WorkspaceController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: createAppBar(context: context, showActionButtons: true),
        body: CenteredBox(
          column: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  await workspaceController.setWorkspaceByUser();
                  workspaceController.nextScreen();
                },
                child: const DefaultText(text: 'Selecciona área de trabajo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
