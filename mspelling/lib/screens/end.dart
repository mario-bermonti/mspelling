import 'package:flutter/material.dart';
import 'package:mspelling/constants.dart';

class EndScreen extends StatefulWidget {
  const EndScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              '¡Terminamos!',
            ),
          ],
        ),
      ),
    );
  }
}
