import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:audioplayers/audioplayers.dart';

class TrialStimScreen extends StatefulWidget {
  /// In this screen we present the stims to participants

  final String stim;

  const TrialStimScreen({Key? key, required this.stim}) : super(key: key);

  @override
  State<TrialStimScreen> createState() => _TrialStimScreenState();
}

class _TrialStimScreenState extends State<TrialStimScreen> {
  final AudioPlayer _audioplayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    run();
  }

  @override
  void dispose() {
    _audioplayer.dispose();
    super.dispose();
  }

  /// Controls the sequence of events.
  void run() {
    _presentStim();
    _goBack();
  }

  /// Present the stim once to the participant
  void _presentStim() async {
    String stim = widget.stim;
    AssetSource source = AssetSource('audio/$stim.wav');
    await _audioplayer.setSource(source);
    await _audioplayer.play(source);
  }

  /// Includes a ISI
  void _goBack() {
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
      body: _buildUI(),
    );
  }

  CenteredBox _buildUI() {
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
