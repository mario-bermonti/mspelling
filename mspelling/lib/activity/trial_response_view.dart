import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/common/centeredbox.dart';
import 'package:mspelling/common/default_appbar.dart';
import 'package:mspelling/common/default_text.dart';
import 'package:mspelling/common/default_textfield.dart';
import 'package:mspelling/common/spacing_holder.dart';
import 'package:mspelling/activity/trial_response_controller.dart';

class TrialResponseView extends StatelessWidget {
  /// Screen for collecting response from participant

  final TrialResponseController _trialResponseController =
      Get.put(TrialResponseController());

  TrialResponseView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: createAppBar(context: context),
        body: CenteredBox(
          column: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const DefaultText(
                text: 'Escribe la palabra:',
              ),
              const BetweenWidgetsSpace(),
              DefaultTextField(
                  controller: _trialResponseController.textController),
              const BetweenWidgetsSpace(),
              ElevatedButton(
                onPressed: () {
                  _trialResponseController.submit();
                  _trialResponseController.toNextScreen();
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
