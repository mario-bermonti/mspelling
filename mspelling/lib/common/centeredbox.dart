import 'package:flutter/material.dart';

/// Custom widget to present widgets centered
class CenteredBox extends StatelessWidget {
  final Column column;

  @override
  const CenteredBox({Key? key, required this.column}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(width: 250.00, height: 300.00, child: column),
    );
  }
}
