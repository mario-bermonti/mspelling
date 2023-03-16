import 'package:flutter/material.dart';
import 'package:mspelling/components/default_appbar.dart';
import 'package:mspelling/components/default_text.dart';

class EndScreen extends StatelessWidget {
  /// Communicate the participant the task has ended.
  /// Doesn't allow going back or restarting so the experimenter has control
  /// over the session.

  const EndScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: createAppBar(),
        body: _buildUI(),
      ),
    );
  }

  Center _buildUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          DefaultText(
            text: '¡Terminamos!',
          ),
        ],
      ),
    );
  }
}
