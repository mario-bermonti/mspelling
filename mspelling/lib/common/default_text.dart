import 'package:flutter/material.dart';

/// Custom text widget with predefined style
class DefaultText extends StatelessWidget {
  final String text;

  const DefaultText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}
