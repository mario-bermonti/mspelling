import 'package:get/get.dart';
import 'package:mspelling/controllers/spelling_controller.dart';

class RestController extends GetxController {
  SpellingController spellingController = Get.find();

  void toNextScreen() {
    Future.delayed(const Duration(milliseconds: 500), () {
      spellingController.run();
    });
  }
}
