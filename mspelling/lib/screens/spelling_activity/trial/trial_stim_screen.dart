import 'package:flutter/material.dart';
import 'package:mspelling/components/default_appbar.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:audioplayers/audioplayers.dart';

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

  /// TODO Check if awaiting it fixed bug where stim sound is not presented
  /// Present the stim once to the participant
  void _presentStim() async {
    String path = '${widget.workspace}/stim/${widget.stim}.wav';

    Source source = DeviceFileSource(path);
    _audioplayer.play(source);
  }
  }

  /// Includes a ISI
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
        body: const TrialStimBody(),
      ),
    );
  }
}

class TrialStimBody extends StatelessWidget {
  const TrialStimBody({
    Key? key,
  }) : super(key: key);

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
