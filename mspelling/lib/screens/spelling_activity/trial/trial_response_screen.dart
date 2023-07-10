import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/components/default_appbar.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/components/default_textfield.dart';
import 'package:mspelling/components/spacing_holder.dart';
import 'package:mspelling/controllers/spelling_controller.dart';

class TrialResponseScreen extends StatefulWidget {
  /// Screen for collecting response from participant

  const TrialResponseScreen({Key? key}) : super(key: key);

  @override
  State<TrialResponseScreen> createState() => _TrialResponseScreenState();
}

class _TrialResponseScreenState extends State<TrialResponseScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: createAppBar(context: context),
        body: TrialResponseBody(textController: _textController),
      ),
    );
  }
}

class TrialResponseBody extends StatelessWidget {
  final SpellingController spellingController = Get.find();
  final TextEditingController textController;

  TrialResponseBody({
    Key? key,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CenteredBox(
      column: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const DefaultText(
            text: 'Escribe la palabra:',
          ),
          const BetweenWidgetsSpace(),
          DefaultTextField(controller: textController),
          const BetweenWidgetsSpace(),
          ElevatedButton(
            onPressed: () {
              submitResponse();
              goBack(context);
            },
            child: const DefaultText(text: 'Seguir'),
          ),
        ],
      ),
    );
  }

  void submitResponse() {
    /// We assume leading or trailing whitespace do not impact response.
    /// Just like when writing using paper-and-pencil and there
    /// is trailling whitespace space
    String response = textController.text.trim();

    /// TODO Improve, very coupled
    spellingController.database.addTrialData(
      participantId: spellingController.participantId,
      stim: spellingController.stimuli.currentStim,
      resp: response,
      sessionNumber: spellingController.sessionNumber,
    );
  }

  void goBack(BuildContext context) {
    spellingController.run();
  }
}
