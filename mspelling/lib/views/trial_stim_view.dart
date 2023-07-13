import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/components/default_appbar.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/controllers/trial_stim_controller.dart';

class TrialStimView extends StatelessWidget {
  /// In this screen we present the stims to participants

  TrialStimView({
    Key? key,
  }) : super(key: key);

  final TrialStimController trialstimController =
      Get.put(TrialStimController());

  @override
  Widget build(BuildContext context) {
    // trialstimController.prepareStim();
    trialstimController.presentStim();
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: createAppBar(context: context),
            body: //Obx(
                //   () {
                // if (trialstimController.ready.value) {
                // return CenteredBox(
                CenteredBox(
              column: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/listen.jpeg'),
                ],
              ),
            )));
    // } else {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
    // },
    //     ),
    //   ),
    // );
  }
}
