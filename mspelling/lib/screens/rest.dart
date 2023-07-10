import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mspelling/components/default_appbar.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/components/spacing_holder.dart';
import 'package:mspelling/controllers/spelling_controller.dart';

class RestScreen extends StatelessWidget {
  final String participantId;

  const RestScreen(this.participantId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: createAppBar(context: context),
        body: RestScreenBody(),
      ),
    );
  }
}

class RestScreenBody extends StatelessWidget {
  final SpellingController spellingController = Get.find();

  RestScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const DefaultText(
            text: 'Descansa',
          ),
          const BetweenWidgetsSpace(),
          ElevatedButton(
            onPressed: () {
              Future.delayed(const Duration(milliseconds: 500), () {
                spellingController.run();
              });
            },
            child: const DefaultText(text: 'Comenzar'),
          ),
        ],
      ),
    );
  }

  void goBack(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      spellingController.run();
    });
  }
}
