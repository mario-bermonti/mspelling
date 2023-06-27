import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/controllers/spelling_controller.dart';
import 'package:mspelling/controllers/status.dart';
import 'package:mspelling/errors.dart';
import 'package:mspelling/screens/end.dart';
import 'package:mspelling/screens/errors.dart';
import 'package:mspelling/screens/rest.dart';
import 'package:mspelling/screens/spelling_activity/trial/trial_response_screen.dart';
import 'package:mspelling/screens/spelling_activity/trial/trial_stim_screen.dart';

// Controls the task's sequences
// Has no ui representation itself
class SpellingView extends StatefulWidget {
  final String participantId;

  const SpellingView(this.participantId, {Key? key}) : super(key: key);

  @override
  State<SpellingView> createState() => _SpellingViewState();
}

class _SpellingViewState extends State<SpellingView> {
  /// Flag to indicate whether the ui can be displayed
  late Future<bool> setupDone;
  late final SpellingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SpellingController(widget.participantId));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: setupDone,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              /// TODO it's necessary to cast as mspelling error?
              return ErrorScreen(message: snapshot.error as MSpellingExeption);
            } else {
              switch (controller.status) {
                case Status.stim:
                  controller.stimuli.next();
                  controller.updateStatus();
                  return TrialStimScreen(
                    workspace: controller.workspace!,
                    stim: controller.stimuli.currentStim,
                  );
                case Status.response:
                  controller.updateStatus();
                  return const TrialResponseScreen();
                case Status.rest:
                  controller.updateStatus();
                  return RestScreen(widget.participantId);
                case Status.completed:
                  controller.updateStatus();
                  return const EndScreen();
              }
            }
          } else {
            return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
