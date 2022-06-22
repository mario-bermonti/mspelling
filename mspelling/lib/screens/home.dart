import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'package:mspelling/components/centeredbox.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/components/default_textfield.dart';
import 'package:mspelling/components/spacing_holder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
      ),
      body: CenteredBox(
        column: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const DefaultText(
              text: 'Id participante:',
            ),
            const SpacingHolder(),
            const DefaultTextField(),
            const SpacingHolder(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/begin');
              },
              child: const DefaultText(text: 'Seguir'),
            ),
          ],
        ),
      ),
    );
  }
}
