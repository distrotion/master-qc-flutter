import 'package:flutter/material.dart';
import 'MaterailMaster/MaterailMaster-main.dart';
import 'page0.dart';
import '../data/global.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page3Body();
  }
}

class Page3Body extends StatelessWidget {
  const Page3Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MatMasterTableINPUT(),
    );
  }
}
