import 'package:flutter/material.dart';

class InspSTdOPTIONBuffer extends StatelessWidget {
  const InspSTdOPTIONBuffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InspSTdOPTION();
  }
}

class InspSTdOPTION extends StatelessWidget {
  const InspSTdOPTION({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              width: 1195,
              height: 260,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
