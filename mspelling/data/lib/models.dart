import 'dart:io';
import 'package:flutter/material.dart' as m;
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';

class Sessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionNumber => integer()();
  TextColumn get participantId => text()();
  DateTimeColumn get timeStart => dateTime()();
  DateTimeColumn get timeEnd => dateTime()();
}

class Trials extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get participantId => text()();
  TextColumn get stim => text()();
  TextColumn get resp => text()();
  IntColumn get sessionNumber =>
      integer().references(Sessions, #sessionNumber)();
}

class Devices extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get participantId => text()();
  TextColumn get platform => text().withDefault(Constant(getPlatform()))();
  RealColumn get height => real().withDefault(Constant(getHeight))();
  RealColumn get width => real().withDefault(Constant(getWidth))();
  RealColumn get aspectRatio => real().withDefault(Constant(getAspectRatio))();
  IntColumn get sessionNumber =>
      integer().references(Sessions, #sessionNumber)();

  double get getHeight => m.WidgetsBinding.instance.window.physicalSize.height;
  double get getWidth => m.WidgetsBinding.instance.window.physicalSize.width;
  double get getAspectRatio =>
      m.WidgetsBinding.instance.window.physicalSize.aspectRatio;
}

/// Get the current platform
/// Options are "web", "android", "fuchsia", "ios", "linux", "macos", "windows"
String getPlatform({
  bool webChecker = kIsWeb,
  String? otherPlatformChecker,
}) {
  if (webChecker) {
    return 'web';
  }

  /// To have "default value"; [Platform.operatingSystem] is not constant
  otherPlatformChecker ??= Platform.operatingSystem;
  return otherPlatformChecker;
}
