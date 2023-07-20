import 'package:flutter/material.dart';

/// Custom widget for including standardized space between widgets
class BetweenWidgetsSpace extends StatelessWidget {
  const BetweenWidgetsSpace({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10);
  }
}
