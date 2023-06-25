import 'package:flutter_test/flutter_test.dart';
import 'package:data/models.dart';

void main() {
  // testWidgets('models current date, time not included', (tester) async {
  //   // obs
  //   sessionNumber sessionNumber = sessionNumber(
  //     participantId: '01',
  //     timeStart: TimeOfDay.now(),
  //     timeEnd: TimeOfDay.now(),
  //   );

  //   DateTime obs = DateTime(sessionNumber.date.month, sessionNumber.date.day);

  //   // exp
  //   DateTime currentDateTime = DateTime.now().toLocal();
  //   DateTime exp = DateTime(
  //       currentDateTime.year, currentDateTime.month, currentDateTime.day);

  //   expect(obs, exp);
  // });
  getPlatformTest();
}

void getPlatformTest() {
  testWidgets('models platform web', (tester) async {
    String platform =
        getPlatform(webChecker: true, otherPlatformChecker: 'macos');
    expect(platform, 'web');
  });
  testWidgets('models platform not web', (tester) async {
    String platform =
        getPlatform(webChecker: false, otherPlatformChecker: 'macos');
    expect(platform, 'macos');
  });
}
