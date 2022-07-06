import 'package:flutter_test/flutter_test.dart';
import 'package:mspelling/stim.dart';

void main() async {
  stimFromFileTest();
  nextStimTest();
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
        String actual = stimuli.next();

        expect(actual, exp);
      });
      testWidgets('second item', (tester) async {
        var stimList = <String>['a', 'b', 'c'];
        Stimuli stimuli = Stimuli(stimuli: stimList);

        String exp = 'b';
        stimuli.next();
        String actual = stimuli.next();

        expect(actual, exp);
      });
    },
  );
}
