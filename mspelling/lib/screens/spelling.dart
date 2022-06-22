import 'package:flutter/material.dart';
import 'package:mspelling/styles.dart';
import 'package:mspelling/constants.dart';

import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/components/default_textfield.dart';
import 'package:mspelling/components/spacing_holder.dart';

class SpellingScreen extends StatefulWidget {
  const SpellingScreen({Key? key}) : super(key: key);

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
            const SpacingHolder(),
            const DefaultTextField(),
            const SpacingHolder(),
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
