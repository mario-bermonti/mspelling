import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';

class BeginScreen extends StatefulWidget {
  const BeginScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BeginScreen> createState() => _BeginScreenState();
}

class _BeginScreenState extends State<BeginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Comencemos',
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/spelling');
              },
              child: const Text('Seguir'),
            ),
          ],
        ),
      ),
    );
  }
}
