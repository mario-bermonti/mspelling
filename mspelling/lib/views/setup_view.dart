import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/setup_manager.dart';
import 'package:mspelling/views/loading_view.dart';

class SetupView extends StatelessWidget {
  SetupView({super.key});

  final SetupController setupController = Get.put(SetupController());

  @override
  Widget build(BuildContext context) {
    return const LoadingView();
  }
}