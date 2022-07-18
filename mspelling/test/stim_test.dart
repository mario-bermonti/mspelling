import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mspelling/stim.dart';

void main() async {
  stimFromFileTest();
  nextStimTest();
  randomizeTest();
  stimCountOriginalTest();
  stimCountRemainingTest();
  stimCountUsedTest();
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
  testWidgets('Compare lists', (tester) async {
    final stimList = <String>['a', 'b', 'c'];
    // Required so a copy of [stimList] is passed,
    // instead of being passed by reference.
    Stimuli stimuli = Stimuli(stimuli: List.from(stimList));

    stimuli.randomize();
    final equal = listEquals(stimList, stimuli.stimuli);

    expect(equal, false);
  });
}

stimCountOriginalTest() async {
  testWidgets('Original stim count doesn\'t change', (tester) async {
    final stimList = <String>['a', 'b', 'c'];
    Stimuli stimuli = Stimuli(stimuli: stimList);

    stimuli.next();
    int actual = stimuli.stimCountOriginal;

    expect(actual, 3);
  });
}

stimCountRemainingTest() async {
  group('Remaining stim count', () {
    testWidgets('Non used', (tester) async {
      final stimList = <String>['a', 'b', 'c'];
      Stimuli stimuli = Stimuli(stimuli: stimList);

      int actual = stimuli.stimCountRemaining;

      expect(actual, 3);
    });
    testWidgets('stim used', (tester) async {
      final stimList = <String>['a', 'b', 'c'];
      Stimuli stimuli = Stimuli(stimuli: stimList);

      stimuli.next();
      stimuli.next();
      int actual = stimuli.stimCountRemaining;

      expect(actual, 1);
    });
  });
}

stimCountUsedTest() async {
  group('Used stim count', () {
    testWidgets('Non used', (tester) async {
      final stimList = <String>['a', 'b', 'c'];
      Stimuli stimuli = Stimuli(stimuli: stimList);

      int actual = stimuli.stimCountUsed;

      expect(actual, 0);
    });
    testWidgets('Stim used', (tester) async {
      final stimList = <String>['a', 'b', 'c'];
      Stimuli stimuli = Stimuli(stimuli: stimList);

      stimuli.next();
      int actual = stimuli.stimCountUsed;

      expect(actual, 1);
    });
  });
}
