import 'package:flutter/material.dart';
import 'package:mspelling/components/default_appbar.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/components/default_textfield.dart';
import 'package:mspelling/components/spacing_holder.dart';

class TrialResponseScreen extends StatefulWidget {
  /// Screen for collecting response from participant

  const TrialResponseScreen({Key? key}) : super(key: key);

  @override
  State<TrialResponseScreen> createState() => _TrialResponseScreenState();
}

class _TrialResponseScreenState extends State<TrialResponseScreen> {
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
        appBar: createAppBar(context: context),
        body: TrialResponseBody(controller: _controller),
      ),
    );
  }
}

class TrialResponseBody extends StatelessWidget {
  const TrialResponseBody({
    Key? key,
    required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;

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
          DefaultTextField(controller: _controller),
          const BetweenWidgetsSpace(),
          ElevatedButton(
            onPressed: () {
              goBack(context);
            },
            child: const DefaultText(text: 'Seguir'),
          ),
        ],
      ),
    );
  }

  void goBack(BuildContext context) {
    Navigator.pop(
      context,

      /// We assume leading or trailing whitespace do not impact response.
      /// Just like when writing using paper-and-pencil and there
      /// is trailling whitespace space
      _controller.text.trim(),
    );
  }
}
