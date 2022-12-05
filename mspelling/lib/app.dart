import 'package:flutter/material.dart';
import 'package:mspelling/screens/home.dart';
import 'package:mspelling/styles.dart';

class MSpelling extends StatelessWidget {
  const MSpelling({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mSpelling',
      theme: themeData,
      home: const HomeScreen(),
    );
  }
}
