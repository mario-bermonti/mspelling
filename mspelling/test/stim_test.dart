import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mspelling/stim.dart';

void main() async {
  stimFromFileTest();
  nextStimTest();
  randomizeTest();
  originalStimCountTest();
}

stimFromFileTest() async {
  testWidgets('Assets folder', (tester) async {
    final s = await Stimuli.fromFile('assets/words/words.txt');
    expect(s.stimuli, ['del', 'dos']);
  });
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
    /// There are 2 lists because they are passed
    /// by referenced when passed as parameters
    final stimOriginal = <String>['a', 'b', 'c'];
    final stimList = <String>['a', 'b', 'c'];
    Stimuli stimuli = Stimuli(stimuli: stimList);

    stimuli.randomize();
    final equal = listEquals(stimOriginal, stimuli.stimuli);

    expect(equal, false);
  });
}

originalStimCountTest() async {
  testWidgets('Original stim size doesn\'t change', (tester) async {
    final stimList = <String>['a', 'b', 'c'];
    Stimuli stimuli = Stimuli(stimuli: stimList);

    stimuli.next();
    int actual = stimuli.originalStimCount;

    expect(actual, 3);
  });
}
