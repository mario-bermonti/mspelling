import 'package:flutter/material.dart';
import 'package:mspelling/common/centeredbox.dart';
import 'package:mspelling/common/default_appbar.dart';
import 'package:mspelling/common/default_text.dart';

/// Screen for instructing the participant the task has ended.
/// Doesn't allow going back or restarting so the experimenter has control
/// over the session.
class EndView extends StatelessWidget {
  const EndView({Key? key}) : super(key: key);

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
            children: const <Widget>[
              DefaultText(
                text: '¡Terminamos!',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
