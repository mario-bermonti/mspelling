import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';
import 'components/centeredbox.dart';
import 'components/default_text.dart';
import 'components/default_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

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
            const DefaultTextField(),
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
