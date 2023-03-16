import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/components/default_textfield.dart';
import 'package:mspelling/components/spacing_holder.dart';
import 'package:mspelling/screens/workspace/utils.dart';

import 'begin_message.dart';

class LoginScreen extends StatefulWidget {
  // Home screen which requires users to login by using their
  // participant ids.

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          actions: const <Widget>[
            IconButton(
                icon: Icon(Icons.settings),
                tooltip: 'Directorio de trabajo',
                onPressed: setWorkspaceByUser)
          ],
        ),
        body: _buildUI(context),
      ),
    );
  }

  CenteredBox _buildUI(BuildContext context) {
    return CenteredBox(
      column: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const DefaultText(
            text: 'Id participante:',
          ),
          const BetweenWidgetsSpace(),
          DefaultTextField(controller: _controller),
          const BetweenWidgetsSpace(),
          ElevatedButton(
            onPressed: () {
              String participantId =
                  _controller.text.trim(); // spaces are meaningless in ids.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BeginScreen(participantId),
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
