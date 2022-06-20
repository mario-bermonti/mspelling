import 'package:flutter/material.dart';
import 'package:mspelling/styles.dart';

class SpellingScreen extends StatefulWidget {
  const SpellingScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends State<SpellingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Escribe la palabra:',
            ),
            const TextField(
              decoration: textFieldStyle,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/end');
              },
              child: const Text('Seguir'),
            ),
          ],
        ),
      ),
    );
  }
}
