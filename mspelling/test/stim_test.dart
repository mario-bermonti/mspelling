import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mspelling/stim.dart';

void main() async {
  stimFromFileTest();
  nextStimTest();
  randomizeTest();
}

stimFromFileTest() async {
  group(
    'Build from text file',
    () {
      testWidgets('Assets folder', (tester) async {
        final s = await Stimuli.fromFile('assets/words/words.txt');
        expect(s.stimuli, ['del', 'dos']);
      });
    },
  );
}

nextStimTest() async {
  group(
    'Get next item from stim',
    () {
      testWidgets('first item', (tester) async {
        var stimList = <String>['a', 'b', 'c'];
        Stimuli stimuli = Stimuli(stimuli: stimList);

        String exp = 'a';
        stimuli.next();
        String actual = stimuli.currentStim;

        expect(actual, exp);
      });
      testWidgets('second item', (tester) async {
        var stimList = <String>['a', 'b', 'c'];
        Stimuli stimuli = Stimuli(stimuli: stimList);

        String exp = 'b';
        stimuli.next();
        stimuli.next();
        String actual = stimuli.currentStim;

        expect(actual, exp);
      });
    },
  );
}

randomizeTest() async {
  testWidgets('compare lists', (tester) async {
    final stimOriginal = <String>['a', 'b', 'c'];
    final stimList = <String>['a', 'b', 'c'];
    Stimuli stimuli = Stimuli(stimuli: stimList);

    stimuli.randomize();
    final equal = listEquals(stimOriginal, stimuli.stimuli);

    expect(equal, false);
  });
}
