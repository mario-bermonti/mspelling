import 'package:flutter/material.dart';

class Session {
  String participantId;
  DateTime date = DateTime.now().toLocal();
  TimeOfDay timeStart;
  TimeOfDay timeEnd;

  Session(
      {required this.participantId,
      required this.timeStart,
      required this.timeEnd});
}

class Trial {
  String participantId;
  String stim;
  String resp;

  Trial({required this.participantId, required this.stim, required this.resp});
}
