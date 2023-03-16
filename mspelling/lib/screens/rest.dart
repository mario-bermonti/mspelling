import 'package:flutter/material.dart';
import 'package:mspelling/components/default_appbar.dart';
import 'package:mspelling/components/default_text.dart';
import 'package:mspelling/components/spacing_holder.dart';

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
        body: _buildUI(context),
      ),
    );
  }

  Center _buildUI(BuildContext context) {
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
                Navigator.pop(context);
              });
            },
            child: const DefaultText(text: 'Comenzar'),
          ),
        ],
      ),
    );
  }
}
