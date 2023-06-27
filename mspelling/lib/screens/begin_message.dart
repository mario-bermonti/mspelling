import 'package:flutter/material.dart';
import 'package:mspelling/components/default_appbar.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/components/spacing_holder.dart';
import 'package:mspelling/screens/spelling_activity/spelling_screen.dart';
import 'package:mspelling/views/spelling_view.dart';

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
        appBar: createAppBar(context: context, showActionButtons: true),
        body: BeginMessageBody(participantId: participantId),
      ),
    );
  }
}

class BeginMessageBody extends StatelessWidget {
  const BeginMessageBody({
    Key? key,
    required this.participantId,
  }) : super(key: key);

  final String participantId;

  @override
  Widget build(BuildContext context) {
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
              gotoSpellingActivity(context);
            },
            child: const DefaultText(text: 'Seguir'),
          ),
        ],
      ),
    );
  }

  void gotoSpellingActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SpellingView(participantId),
      ),
    );
  }
}
