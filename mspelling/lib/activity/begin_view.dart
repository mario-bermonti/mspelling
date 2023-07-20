import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mspelling/common/centeredbox.dart';
import 'package:mspelling/common/default_appbar.dart';
import 'package:mspelling/common/default_text.dart';
import 'package:mspelling/common/spacing_holder.dart';
import 'package:mspelling/activity/spelling_controller.dart';

class BeginView extends StatelessWidget {
  // Allows the user to indicate when to start task.

  const BeginView({Key? key}) : super(key: key);

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
              const DefaultText(
                text: 'Comencemos',
              ),
              const BetweenWidgetsSpace(),
              ElevatedButton(
                onPressed: () {
                  Get.put(SpellingController());
                },
                child: const DefaultText(text: 'Seguir'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
