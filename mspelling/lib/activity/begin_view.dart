import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mspelling/common/centeredbox.dart';
import 'package:mspelling/common/default_appbar.dart';
import 'package:mspelling/common/default_text.dart';
import 'package:mspelling/common/spacing_holder.dart';
import 'package:mspelling/activity/spelling_controller.dart';

/// Screen that allows participants to indicate when to start task.
class BeginView extends StatelessWidget {
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
