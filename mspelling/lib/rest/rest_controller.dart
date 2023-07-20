import 'package:get/get.dart';
import 'package:mspelling/activity/spelling_controller.dart';

class RestController extends GetxController {
  SpellingController spellingController = Get.find();

  /// Goes to next screen after 500ms ISI
  void toNextScreen() {
    Future.delayed(const Duration(milliseconds: 500), () {
      spellingController.run();
    });
  }
}
