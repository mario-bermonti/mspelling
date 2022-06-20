import 'package:flutter/material.dart';
import 'package:mspelling/styles.dart';

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
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Id participante:',
            ),
            const TextField(
              decoration: textFieldStyle,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/begin');
              },
              child: const Text('Seguir'),
            ),
          ],
        ),
      ),
    );
  }
}
