import 'package:flutter/material.dart';
import 'package:mspelling/setup_manager.dart';
import 'package:mspelling/styles.dart';

class MSpellingApp extends StatelessWidget {
  const MSpellingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mSpelling',
      theme: themeData,
      home: const SetupManager(),
    );
  }
}
