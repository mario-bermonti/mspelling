import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/controllers/setup_controller.dart';
import 'package:mspelling/common/loading_view.dart';

class SetupView extends StatelessWidget {
  SetupView({super.key});

  final SetupController setupController = Get.put(SetupController());

  @override
  Widget build(BuildContext context) {
    return const LoadingView();
  }
}
