import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/setup/setup_controller.dart';
import 'package:mspelling/common/loading_view.dart';

/// Presents a loading screen while everything is set up
class SetupView extends StatelessWidget {
  SetupView({super.key});

  final SetupController setupController = Get.put(SetupController());

  @override
  Widget build(BuildContext context) {
    return const LoadingView();
  }
}
