import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/common/default_appbar.dart';
import 'package:mspelling/common/centeredbox.dart';
import 'package:mspelling/controllers/stim_controller.dart';

class TrialStimView extends StatelessWidget {
  /// In this screen we present the stims to participants

  TrialStimView({
    Key? key,
  }) : super(key: key);

  final StimController _stimController = Get.find();

  @override
  Widget build(BuildContext context) {
    _stimController.stim.next();
    _stimController.presentStim();
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
                  Image.asset('assets/images/listen.jpeg'),
                ],
              ),
            )));
  }
}
