import 'package:flutter/services.dart';

class Stimuli {
  List<String> stimuli = [];

  // Build Stim from a text file specified by
  // the path filePath
  Stimuli.fromFile(String filePath) {
    _buildFromTxt(filePath);
  }

  // Helper method to build Stim from a text file
  // This needs to happen in an async method and
  // constructors can't be async
  _buildFromTxt(String filePath) async {
    String wordsString = await rootBundle.loadString(filePath);
    List<String> wordsList = wordsString.split('\n');
    stimuli = wordsList;
  }
}
