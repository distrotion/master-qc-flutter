import 'package:flutter/material.dart';

import 'InspectionStandart-01-header.dart';
import 'InspectionStandart-02-incoming.dart';
import 'InspectionStandart-04-final.dart';
import 'InspectionStandart-05-options.dart';

class InspStdbody extends StatelessWidget {
  const InspStdbody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InspStdbodyBuffer();
  }
}

class InspStdbodyBuffer extends StatelessWidget {
  const InspStdbodyBuffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InspStdbodyMain();
  }
}

class InspStdbodyMain extends StatelessWidget {
  const InspStdbodyMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 300,
            child: InspSTdHeaderBuffer(),
          ),
          Container(
            // color: Colors.blue,
            height: 450,
            child: InspSTdINCOMINGTableBUFFER(),
          ),
          Container(
            // color: Colors.green,
            height: 450,
            child: InspSTdFinalTableBUFFER(),
          ),
          Container(
            height: 300,
            child: InspSTdOPTIONBuffer(),
          ),
        ],
      ),
    );
  }
}
