import 'package:flutter/material.dart';
import 'package:mspelling/styles.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;

  const DefaultTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: textFieldStyle,
      autofocus: true,
      controller: controller,
    );
  }
}
