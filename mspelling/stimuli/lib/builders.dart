/// Functions that help build a Stimuli object from a file listing the stimuli

import 'dart:io';
import 'package:stimuli/errors.dart';
import 'package:stimuli/stim.dart';

/// Build [Stimuli] from a text file specified by
/// the path filePath.
Future<Stimuli> createStimFromFile(String filePath) async {
  File file = File(filePath);
  await validateStimFileExists(file, filePath);
  List<String> stimList = await file.readAsLines();
  Stimuli stim = Stimuli(stimuli: stimList);

  return stim;
}

Future<void> validateStimFileExists(File file, String filePath) async {
  if (await file.exists() == false) {
    throw StimFileAccessException();
  }
}
