import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/screens/end.dart';
import 'package:mspelling/screens/rest.dart';
import 'package:mspelling/screens/spelling_activity/trial/trial_response_screen.dart';
import 'package:mspelling/screens/spelling_activity/trial/trial_stim_screen.dart';
import 'package:mspelling/stim.dart';

class SpellingScreen extends StatefulWidget {
  final String participantId;

  const SpellingScreen(this.participantId, {Key? key}) : super(key: key);

  @override
  State<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends State<SpellingScreen> {
  late final Stimuli _stimuli;
  final bool _restActive = false;
  final TimeOfDay timeStart = TimeOfDay.now();
  late final TimeOfDay timeEnd;

  @override
  initState() {
    super.initState();
    getStimuli();
  }

  void run(context) {
    if (_stimuli.stimCountRemaining == 0) {
      endSession();
      return;
    }
    presentTrial(context);
    presentRestCond();
  }

  getStimuli() async {
    Stimuli stimuli = await createStimFromFile('assets/stimuli/stimuli.txt');
    stimuli.randomize();
    _stimuli = stimuli;
  }

  void presentTrial(context) async {
    _stimuli.next();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrialStimScreen(stim: _stimuli.currentStim),
      ),
    );

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TrialResponseScreen(),
      ),
    );
  }

  void presentRestCond() {
    if (_restActive) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RestScreen(widget.participantId),
        ),
      );
    }
  }

  void endSession() {
    timeEnd = TimeOfDay.now();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EndScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
        automaticallyImplyLeading: false,
      ),
      body: CenteredBox(
        column: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                run(context);
              },
              child: const DefaultText(text: 'Seguir'),
            ),
          ],
        ),
      ),
    );
  }
}
