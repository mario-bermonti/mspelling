import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:audioplayers/audioplayers.dart';

class TrialStimScreen extends StatefulWidget {
  final String word;

  const TrialStimScreen({Key? key, required this.word}) : super(key: key);

  @override
  // This is not recommended but it was the only way to have access to word
  // from the state.
  // Using $widget.word causes errors; this just causes a warning.
  State<TrialStimScreen> createState() => _TrialStimScreenState(word);
}

class _TrialStimScreenState extends State<TrialStimScreen> {
  final audioplayer = AudioPlayer();
  final String word;

  _TrialStimScreenState(this.word) {
    run();
  }

  // // @override
  // // void initState() {
  // //   super.initState();
  // //   // audioplayer = AudioPlayer();
  // // }

  // @override
  // void dispose() {
  //   audioplayer.dispose();
  //   super.dispose();
  // }

  void run() {
    playStim();
    goBack();
  }

  void playStim() async {
    AssetSource source = AssetSource('audio/$word.wav');
    await audioplayer.setSource(source);
    await audioplayer.play(source);
  }

  void goBack() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
        automaticallyImplyLeading: false,
      ),
      body: CenteredBox(
        // TODO check if structure can be simplified
        column: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/listen.jpeg'),
          ],
        ),
      ),
    );
  }
}
