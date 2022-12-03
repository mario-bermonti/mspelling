import 'package:flutter/material.dart';
import 'package:mspelling/screens/home.dart';

class MSpelling extends StatelessWidget {
  const MSpelling({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mSpelling',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
