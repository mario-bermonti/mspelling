import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/components/spacing_holder.dart';
import 'package:mspelling/screens/spelling_activity/spelling_screen.dart';

class BeginScreen extends StatelessWidget {
  // Allows the user to indicate when to start task.

  final String participantId;

  const BeginScreen(this.participantId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(appBarTitle),
          automaticallyImplyLeading: false,
        ),
        body: _buildUI(context),
      ),
    );
  }

  Center _buildUI(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const DefaultText(
            text: 'Comencemos',
          ),
          const BetweenWidgetsSpace(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpellingActivity(participantId),
                ),
              );
            },
            child: const DefaultText(text: 'Seguir'),
          ),
        ],
      ),
    );
  }
}
