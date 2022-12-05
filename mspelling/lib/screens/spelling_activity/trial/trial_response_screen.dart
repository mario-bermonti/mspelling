import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
        automaticallyImplyLeading: false,
      ),
      body: CenteredBox(
        column: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildUI(context),
        ),
      ),
    );
  }

  List<Widget> _buildUI(BuildContext context) {
    return <Widget>[
      const DefaultText(
        text: 'Escribe la palabra:',
      ),
      const BetweenWidgetsSpace(),
      DefaultTextField(controller: _controller),
      const BetweenWidgetsSpace(),
      ElevatedButton(
        onPressed: () {
          _goBack(context);
        },
        child: const DefaultText(text: 'Seguir'),
      ),
    ];
  }

  void _goBack(BuildContext context) {
    Navigator.pop(
      context,

      /// We assume leading or trailing whitespace do not impact response.
      /// Just like when writing using paper-and-pencil and there
      /// is trailling whitespace space
      _controller.text.trim(),
    );
  }
}
