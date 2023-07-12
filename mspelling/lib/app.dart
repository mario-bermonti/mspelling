import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/styles.dart';
import 'package:mspelling/views/setup_view.dart';

class MSpellingApp extends StatelessWidget {
  const MSpellingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'mSpelling',
      theme: themeData,
      home: SetupView(),
    );
  }
}
