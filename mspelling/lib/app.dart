import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/setup_manager.dart';
import 'package:mspelling/styles.dart';

class MSpellingApp extends StatelessWidget {
  const MSpellingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'mSpelling',
      theme: themeData,
      home: const SetupManager(),
    );
  }
}
