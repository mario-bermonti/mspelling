import 'package:flutter_test/flutter_test.dart';
import 'package:mspelling/stim.dart';

void main() {
  testWidgets('Stim ...', (tester) async {
    // test('stim ...', () async {
    final s = await Stimuli.fromFile('assets/words/words.txt');
    expect(s.stimuli, ['del', 'dos']);
  });
}
