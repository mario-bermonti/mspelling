import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mspelling/components/default_appbar.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mspelling/errors.dart';
import 'package:mspelling/screens/errors.dart';

class TrialStimScreen extends StatefulWidget {
  /// In this screen we present the stims to participants

  final String stim;
  final String workspace;

  const TrialStimScreen({
    Key? key,
    required this.workspace,
    required this.stim,
  }) : super(key: key);

  @override
  State<TrialStimScreen> createState() => _TrialStimScreenState();
}

class _TrialStimScreenState extends State<TrialStimScreen> {
  final AudioPlayer _audioplayer = AudioPlayer();
  late final Source _source;

  @override
  void dispose() {
    _audioplayer.dispose();
    super.dispose();
  }

  /// Present the stim once to the participant and go to previous screen
  Future<void> run() async {
    await _presentStim();
    _goBack();
  }

  /// Present the stim once to the participant
  Future<void> _presentStim() async {
    await _audioplayer.play(_source);
  }

  /// Prepare the stim that will be presented
  /// Expects the stim to be in a dir named 'stim' in the workspace
  Future<void> prepareStim() async {
    String path = '${widget.workspace}/stim/${widget.stim}.wav';
    await validateAudioStimFile(path);
    _source = DeviceFileSource(path);
    await _audioplayer.setSourceDeviceFile(path);
  }

  /// Validate the audio stim file exists
  Future<void> validateAudioStimFile(String path) async {
    File file = File(path);
    if (await file.exists() == false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ErrorScreen(
              message: GenericMSpellingException(
                  'Error playing the audio stim file')),
        ),
      );
    }
  }

  /// Go to spelling widget after ISI
  void _goBack() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: createAppBar(context: context),
        body: FutureBuilder(
          future: setup(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text("Error");
              } else {
                return WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: const TrialStimBody(),
                );
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
          },
        ),
      ),
    );
  }

  /// Prepare stim and present it
  Future<void> setup() async {
    await prepareStim();
    await run();
  }
}

class TrialStimBody extends StatefulWidget {
  const TrialStimBody({
    Key? key,
  }) : super(key: key);

  @override
  State<TrialStimBody> createState() => _TrialStimBodyState();
}

class _TrialStimBodyState extends State<TrialStimBody> {
  @override
  Widget build(BuildContext context) {
    return CenteredBox(
      column: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/listen.jpeg'),
        ],
      ),
    );
  }
}
// 