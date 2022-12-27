/// Functions that help build a Stimuli object from a file listing the stimuli

import 'package:flutter/services.dart';
import 'package:stimuli/stim.dart';

/// Build [Stimuli] from a text file specified by
/// the path filePath.
Future<Stimuli> createStimFromFile(String filePath) async {
  String stimString = await rootBundle.loadString(filePath);
  List<String> stimList = stimString.split('\n');
  Stimuli stim = Stimuli(stimuli: stimList);

  return stim;
}
