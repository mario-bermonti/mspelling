import 'package:flutter/material.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_appbar.dart';
import 'package:mspelling/components/default_text.dart';

class EndView extends StatelessWidget {
  /// Communicate the participant the task has ended.
  /// Doesn't allow going back or restarting so the experimenter has control
  /// over the session.

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
