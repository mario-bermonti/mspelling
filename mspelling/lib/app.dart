import 'package:flutter/material.dart';
import 'package:mspelling/screens/end.dart';
import 'package:mspelling/screens/home.dart';
import 'package:mspelling/screens/begin_message.dart';
import 'package:mspelling/screens/spelling_activity/spelling_screen.dart';
import 'package:mspelling/screens/spelling_activity/trial.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mSpelling',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        '/begin': (context) => const BeginScreen(),
        '/spelling': (context) => const SpellingScreen(),
        '/trial': (context) => const TrialScreen(),
        '/end': (context) => const EndScreen(),
      },
    );
  }
}
