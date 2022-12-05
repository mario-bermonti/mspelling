import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/components/default_text.dart';

class EndScreen extends StatefulWidget {
  /// Communicate the participant the task has ended.
  /// Doesn't allow going back or restarting so the experimenter has control
  /// over the session.

  const EndScreen({Key? key}) : super(key: key);

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
        automaticallyImplyLeading: false,
      ),
      body: _buildUI(),
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
