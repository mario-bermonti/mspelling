import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/components/spacing_holder.dart';

class RestScreen extends StatefulWidget {
  // Rest screen for participants. They start again whenever they want.

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
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const DefaultText(
              text: 'Descansa',
            ),
            const BetweenWidgetsSpace(),
            ElevatedButton(
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pop(context);
                });
              },
              child: const DefaultText(text: 'Comenzar'),
            ),
          ],
        ),
      ),
    );
  }
}
