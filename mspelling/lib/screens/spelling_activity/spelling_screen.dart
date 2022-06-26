import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/screens/rest.dart';
import 'package:mspelling/screens/spelling_activity/trial.dart';

class SpellingScreen extends StatefulWidget {
  const SpellingScreen({Key? key}) : super(key: key);

  @override
  State<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends State<SpellingScreen> {
  List<String> words = <String>['del', 'dos'];
  bool restActive = false;

  void run() {
    presentTrial();
    presentRestCond();
  }

  void presentTrial() async {
    final word = words.removeLast();
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrialScreen(word: word),
      ),
    );
  }

  void presentRestCond() {
    if (restActive) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RestScreen(),
        ),
      );
    }
  }

  void endSession() {
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
                run();
              },
              child: const DefaultText(text: 'Seguir'),
            ),
          ],
        ),
      ),
    );
  }
}
