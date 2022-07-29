import 'dart:io';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

part 'models.g.dart';

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

class Trials extends drift.Table {
  drift.IntColumn get id => integer().autoIncrement()();
  drift.TextColumn get participantId => text()();
  drift.TextColumn get stim => text()();
  drift.TextColumn get resp => text()();
}

class Device {
  Object platform = kIsWeb == true ? 'web' : Platform.operatingSystem;
  double height = WidgetsBinding.instance.window.physicalSize.height;
  double width = WidgetsBinding.instance.window.physicalSize.width;
  double aspectRatio = WidgetsBinding.instance.window.physicalSize.aspectRatio;
}
