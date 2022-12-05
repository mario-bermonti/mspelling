import 'package:flutter/material.dart';
import 'package:mspelling/styles.dart';

class DefaultText extends StatelessWidget {
  final String text;

  const DefaultText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.button,
    );
  }
}
