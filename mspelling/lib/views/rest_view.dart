import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/common/centeredbox.dart';
import 'package:mspelling/common/default_appbar.dart';
import 'package:mspelling/common/default_text.dart';
import 'package:mspelling/common/spacing_holder.dart';
import 'package:mspelling/controllers/rest_controller.dart';

class RestView extends StatelessWidget {
  RestView({super.key});

  final RestController _restController = Get.put(RestController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: createAppBar(context: context),
        body: CenteredBox(
          column: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const DefaultText(
                text: 'Descansa',
              ),
              const BetweenWidgetsSpace(),
              ElevatedButton(
                onPressed: () => _restController.toNextScreen(),
                child: const DefaultText(text: 'Comenzar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
