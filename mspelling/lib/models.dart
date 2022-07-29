import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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

class Device {
  Object platform = kIsWeb == true ? 'web' : Platform.operatingSystem;
  double height = WidgetsBinding.instance.window.physicalSize.height;
  double width = WidgetsBinding.instance.window.physicalSize.width;
  double aspectRatio = WidgetsBinding.instance.window.physicalSize.aspectRatio;
}
