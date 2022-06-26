import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';

class TrialStimScreen extends StatefulWidget {
  final String word;

  const TrialStimScreen({Key? key, required this.word}) : super(key: key);

  @override
  State<TrialStimScreen> createState() => _TrialStimScreenState();
}

class _TrialStimScreenState extends State<TrialStimScreen> {
  var controller = TextEditingController();
  bool allowResponse = true;

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
          children: const <Widget>[
            // TODO Use image instead of text
            DefaultText(
              text: 'Escucha',
            ),
          ],
        ),
      ),
    );
  }
}
