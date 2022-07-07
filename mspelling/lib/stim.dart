import 'package:flutter/services.dart';

class Stimuli {
  /// A list of the stimuli
  late var stimuli = <String>[];

  /// Current stimuli after running the [next] method.
  late String currentStim;

  /// Size of original stim list.
  late int stimCountOriginal;

  /// Default constructor requires a list of stimuli.
  Stimuli({required this.stimuli}) {
    stimCountOriginal = stimuli.length;
  }

  /// Build Stim from a text file specified by
  /// the path filePath.
  Stimuli.fromFile(String filePath) {
    _buildFromTxt(filePath);
    stimCountOriginal = stimuli.length;
  }

  /// Number of stim that remain to be used
  int get stimCountRemaining => stimuli.length;

  /// Number of stim that have been used
  int get stimCountUsed => stimCountOriginal - stimCountRemaining;

  /// Helper method to build Stim from a text file.
  /// This needs to happen in an async method and
  /// constructors can't be async.
  _buildFromTxt(String filePath) async {
    String wordsString = await rootBundle.loadString(filePath);
    List<String> wordsList = wordsString.split('\n');
    stimuli = wordsList;
  }

  /// Get the next stim from stimuli.
  void next() {
    currentStim = stimuli.removeAt(0);
  }

  /// Randomize the order of the stimuli.
  void randomize() {
    stimuli.shuffle();
  }
}
