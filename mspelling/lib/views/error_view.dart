import 'package:flutter/material.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_appbar.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/errors.dart';

/// Present error screen to participant
/// Show specific error
class ErrorView extends StatelessWidget {
  final MSpellingExeption message;

  const ErrorView({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: createAppBar(context: context),
        body: CenteredBox(
          column: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DefaultText(
                text: message.userMessage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
