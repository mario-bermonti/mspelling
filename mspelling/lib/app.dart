import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/routes.dart';
import 'package:mspelling/common/styles.dart';

class MSpellingApp extends StatelessWidget {
  const MSpellingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'mSpelling',
      theme: themeData,
      initialRoute: 'setup',
      getPages: routes,
    );
  }
}
