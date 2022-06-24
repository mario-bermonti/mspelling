import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/components/default_textfield.dart';
import 'package:mspelling/components/spacing_holder.dart';

class TrialScreen extends StatefulWidget {
  final String word;

  const TrialScreen({Key? key, required this.word}) : super(key: key);

  @override
  State<TrialScreen> createState() => _TrialScreenState();
}

class _TrialScreenState extends State<TrialScreen> {
  var controller = TextEditingController();

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
            DefaultTextField(controller: controller),
            const SpacingHolder(),
            ElevatedButton(
              onPressed: () {
                goBackReturnResponse(context);
              },
              child: const DefaultText(text: 'Seguir'),
            ),
          ],
        ),
      ),
    );
  }

  void goBackReturnResponse(BuildContext context) {
    Navigator.pop(
      context,
      'response',
    );
  }
}
