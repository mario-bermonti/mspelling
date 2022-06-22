import 'package:flutter/material.dart';
import 'package:mspelling/styles.dart';
import 'package:mspelling/constants.dart';
import 'components/centeredbox.dart';
import 'components/default_text.dart';
import 'components/default_textfield.dart';

class SpellingScreen extends StatefulWidget {
  const SpellingScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends State<SpellingScreen> {
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
            const DefaultText(
              text: 'Escribe la palabra:',
            ),
            const DefaultTextField(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/end');
              },
              child: const DefaultText(text: 'Seguir'),
            ),
          ],
        ),
      ),
    );
  }
}
