import 'package:flutter/material.dart';

const InputDecoration textFieldStyle = InputDecoration(
  border: OutlineInputBorder(),
);

ThemeData themeData = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  textTheme: const TextTheme(
    button: TextStyle(fontSize: 20),
  ),
);
