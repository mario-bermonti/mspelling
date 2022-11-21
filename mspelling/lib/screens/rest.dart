import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/components/spacing_holder.dart';
import 'package:mspelling/screens/spelling_activity/spelling_screen.dart';

class RestScreen extends StatefulWidget {
  final String participantId;

  const RestScreen(this.participantId, {Key? key}) : super(key: key);

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
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
              text: 'Descansa',
            ),
            const SpacingHolder(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const DefaultText(text: 'Presionar para comenzar'),
            ),
          ],
        ),
      ),
    );
  }
}
