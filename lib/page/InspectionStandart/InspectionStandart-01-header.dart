import 'package:flutter/material.dart';

class InspSTdHeaderBuffer extends StatelessWidget {
  const InspSTdHeaderBuffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InspSTdHeader();
  }
}

class InspSTdHeader extends StatelessWidget {
  const InspSTdHeader({Key? key}) : super(key: key);

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
