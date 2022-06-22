import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';

import 'components/default_text.dart';
import 'components/spacing_holder.dart';

class BeginScreen extends StatefulWidget {
  const BeginScreen({Key? key}) : super(key: key);

  @override
  State<BeginScreen> createState() => _BeginScreenState();
}

class _BeginScreenState extends State<BeginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const DefaultText(
              text: 'Comencemos',
            ),
            const SpacingHolder(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/spelling');
              },
              child: const DefaultText(text: 'Seguir'),
            ),
          ],
        ),
      ),
    );
  }
}
