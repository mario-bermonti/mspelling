/// Functions that help build a Stimuli object from a file listing the stimuli

import 'dart:io';
import 'package:stimuli/stim.dart';

/// Build [Stimuli] from a text file specified by
/// the path filePath.
Future<Stimuli> createStimFromFile(String filePath) async {
  /// TODO fail if file doesn't exist
  /// TODO refactor into 2 methods?
  File file = File(filePath);
  if (await file.exists() == false) {
    throw Exception('stim.txt file not found in $filePath');
  }
  List<String> stimList = await file.readAsLines();
  Stimuli stim = Stimuli(stimuli: stimList);

  return stim;
}
