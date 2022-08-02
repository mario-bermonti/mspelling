import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' as drift;

class Sessions extends drift.Table {
  drift.IntColumn get id => integer().autoIncrement()();
  drift.TextColumn get participantId => text()();
  drift.DateTimeColumn get timeStart => dateTime()();
  drift.DateTimeColumn get timeEnd => dateTime()();
}

class Trials extends drift.Table {
  drift.IntColumn get id => integer().autoIncrement()();
  drift.TextColumn get participantId => text()();
  drift.TextColumn get stim => text()();
  drift.TextColumn get resp => text()();
}

class Devices extends drift.Table {
  drift.IntColumn get id => integer().autoIncrement()();
  drift.TextColumn get platform =>
      text().withDefault(drift.Constant(getPlatform()))();
  drift.RealColumn get height => real().withDefault(
      drift.Constant(WidgetsBinding.instance.window.physicalSize.height))();
  drift.RealColumn get weight => real().withDefault(
      drift.Constant(WidgetsBinding.instance.window.physicalSize.width))();
  drift.RealColumn get aspectRatio => real().withDefault(drift.Constant(
      WidgetsBinding.instance.window.physicalSize.aspectRatio))();
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
