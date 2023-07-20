import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/common/centeredbox.dart';
import 'package:mspelling/common/default_appbar.dart';
import 'package:mspelling/common/default_text.dart';
import 'package:mspelling/common/default_textfield.dart';
import 'package:mspelling/common/spacing_holder.dart';
import 'package:mspelling/login/login_controller.dart';

// Home screen which requires users to login by using their
// participant ids.
class LoginView extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: createAppBar(context: context, showActionButtons: true),
        body: CenteredBox(
          column: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const DefaultText(
                text: 'Id participante:',
              ),
              const BetweenWidgetsSpace(),
              DefaultTextField(controller: _loginController.textController),
              const BetweenWidgetsSpace(),
              ElevatedButton(
                onPressed: () {
                  _loginController.submitParticipantID();
                  _loginController.toNextScreen();
                },
                child: const DefaultText(text: 'Seguir'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
