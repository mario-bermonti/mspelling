import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mspelling/models.dart';

void main() {
  testWidgets('models current date, time not included', (tester) async {
    // obs
    Session session = Session(
      participantId: '01',
      timeStart: TimeOfDay.now(),
      timeEnd: TimeOfDay.now(),
    );

    DateTime obs =
        DateTime(session.date.year, session.date.month, session.date.day);

    // exp
    DateTime currentDateTime = DateTime.now().toLocal();
    DateTime exp = DateTime(
        currentDateTime.year, currentDateTime.month, currentDateTime.day);

    expect(obs, exp);
  });
}
