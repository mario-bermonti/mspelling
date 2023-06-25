import 'package:flutter_test/flutter_test.dart';

import 'package:stimuli/stimuli.dart';

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
    final s = await createStimFromFile('assets/stimuli_tests.txt');
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

/// The rationale behind this test is that if the stimuli is actually
/// randomized, it is highly unlikely that it will yield the orinal order
/// 5 times in a row. Only the first item of each Stimuli are compared because
/// it should be enough.
randomizeTest() async {
  testWidgets('Compare lists', (tester) async {
    final stimList = <String>['a', 'b', 'c'];

    // List.from() is used so a copy of [stimList] is passed,
    // instead of being passed by reference.
    Stimuli stimuli1 = Stimuli(stimuli: List.from(stimList));
    Stimuli stimuli2 = Stimuli(stimuli: List.from(stimList));
    Stimuli stimuli3 = Stimuli(stimuli: List.from(stimList));
    Stimuli stimuli4 = Stimuli(stimuli: List.from(stimList));
    Stimuli stimuli5 = Stimuli(stimuli: List.from(stimList));

    stimuli1.randomize();
    stimuli2.randomize();
    stimuli3.randomize();
    stimuli4.randomize();
    stimuli5.randomize();

    final firstStimulusEachStimuli = <String>[
      stimuli1.stimuli.first,
      stimuli2.stimuli.first,
      stimuli3.stimuli.first,
      stimuli4.stimuli.first,
      stimuli5.stimuli.first,
    ];

    bool obs = firstStimulusEachStimuli.every(((element) => element == 'a'));

    expect(obs, false);
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
