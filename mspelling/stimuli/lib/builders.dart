/// Functions that help build a Stimuli object from a file listing the stimuli

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stimuli/stim.dart';

/// Build [Stimuli] from a text file specified by
/// the path filePath.
Future<Stimuli> createStimFromFile(String filePath) async {
  File file = File(filePath);
  List<String> stimList = await file.readAsLines();
  Stimuli stim = Stimuli(stimuli: stimList);

  return stim;
}
