import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/common/centeredbox.dart';
import 'package:mspelling/common/default_text.dart';
import 'package:mspelling/common/default_appbar.dart';
import 'package:mspelling/setup/setup_controller.dart';

class WorkspaceView extends StatelessWidget {
  WorkspaceView({super.key});

  final SetupController setupController = Get.find();

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
                  await setupController.setWorkspaceByUser();
                  setupController.toNextScreen();
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
