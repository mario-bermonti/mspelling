import 'package:flutter_test/flutter_test.dart';
import 'package:mspelling/stim.dart';

void main() {
  group(
    'Stim',
    () {
      group(
        'Build from text file',
        () {
          testWidgets('Assets folder', (tester) async {
            final s = await Stimuli.fromFile('assets/words/words.txt');
            expect(s.stimuli, ['del', 'dos']);
          });
        },
      );
    },
  );
}
