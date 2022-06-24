import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/screens/spelling_activity/trial.dart';

class SpellingScreen extends StatefulWidget {
  const SpellingScreen({Key? key}) : super(key: key);

  @override
  State<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends State<SpellingScreen> {
  String word = 'gato';

  void trial() async {
    final res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrialScreen(word: word),
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
                trial();
              },
              child: const DefaultText(text: 'Comenzar'),
            ),
          ],
        ),
      ),
    );
  }
}
