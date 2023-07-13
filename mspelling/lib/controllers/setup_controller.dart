import 'package:get/get.dart';
import 'package:mspelling/views/login_view.dart';
import 'package:mspelling/controllers/workspace_controller.dart';

/// Presents the workspace screen if no workspace is available,
/// otherwise presents the login screen
class SetupController extends GetxController {
  WorkspaceController workspaceController = Get.put(WorkspaceController());
  late String? _workspace;

  @override
  Future<void> onInit() async {
    _workspace = await workspaceController.getWorkspace();
    super.onInit();
  }

  @override
  void onReady() {
    toNextScreen();
    super.onReady();
  }

  void toNextScreen() {
    if (_workspace != null) {
      Get.to(LoginView());
    } else {
      Get.to(const SetWorkspaceScreen());
    }
  }
}
