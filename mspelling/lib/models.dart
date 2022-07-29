import 'package:flutter/material.dart';

class Session {
  String participantId;
  DateTime date = getFormattedDate();
  TimeOfDay timeStart;
  TimeOfDay timeEnd;

  Session(
      {required this.participantId,
      required this.timeStart,
      required this.timeEnd});
}

DateTime getFormattedDate() {
  DateTime currentDateTime = DateTime.now().toLocal();
  DateTime currentDate = DateTime(
      currentDateTime.year, currentDateTime.month, currentDateTime.day);
  return currentDate;
}
