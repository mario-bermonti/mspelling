import 'package:flutter/material.dart';
import 'package:mspelling/styles.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: textFieldStyle,
    );
  }
}
