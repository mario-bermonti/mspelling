import 'package:flutter/material.dart';
import 'package:mspelling/components/default_appbar.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/errors.dart';

/// Present error screen to participant
/// Show specific error
class ErrorScreen extends StatelessWidget {
  final MSpellingExeption message;

  const ErrorScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: createAppBar(context: context),
        body: ErrorScreenBody(message: message.userMessage()),
      ),
    );
  }
}

class ErrorScreenBody extends StatelessWidget {
  final String message;

  const ErrorScreenBody({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DefaultText(
              text: message,
            ),
          ],
        ),
      ),
    );
  }
}
