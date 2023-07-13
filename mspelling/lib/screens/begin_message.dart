import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mspelling/components/default_appbar.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/components/spacing_holder.dart';
import 'package:mspelling/controllers/spelling_controller.dart';

class BeginScreen extends StatelessWidget {
  // Allows the user to indicate when to start task.

  const BeginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: createAppBar(context: context, showActionButtons: true),
        body: const BeginMessageBody(),
      ),
    );
  }
}

class BeginMessageBody extends StatelessWidget {
  const BeginMessageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const DefaultText(
            text: 'Comencemos',
          ),
          const BetweenWidgetsSpace(),
          ElevatedButton(
            onPressed: () {
              gotoSpellingActivity(context);
            },
            child: const DefaultText(text: 'Seguir'),
          ),
        ],
      ),
    );
  }

  void gotoSpellingActivity(BuildContext context) {
    Get.put(SpellingController());
  }
}
