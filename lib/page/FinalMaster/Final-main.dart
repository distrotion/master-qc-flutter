import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tpk_qc_master/mainBody.dart';
import 'package:tpk_qc_master/widget/common/Loading.dart';

import '../../bloc/BlocEvent/02-final.dart';
import '../../bloc/Cubit/Rebuild.dart';
import '../../data/global.dart';
import '../../widget/common/ComBtnBlackBorder.dart';
import 'dummydata.dart';
import 'Final-01-type.dart';
import 'Final-02-Unit.dart';
import 'Final-03-ITEMs.dart';
import 'Final-04-MachineName.dart';
import 'Final-05-Method.dart';
import 'Final-06-SpecialSpec.dart';
import 'Final-07-Calculate.dart';
import 'Final-control.dart';

// class TapMainFnlomingBody extends StatelessWidget {
//   /// {@macro counter_page}
//   const TapMainFnlomingBody({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (_) => Fnloming_Bloc(),
//         child: BlocBuilder<Fnloming_Bloc, int>(
//           builder: (context, data) {
//             return TapMainFnlomingBodyB();
//           },
//         ));
//   }
// }

class TapMainFnlomingBody extends StatelessWidget {
  TapMainFnlomingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("FINAL MASTER"),
          SizedBox(
            height: 5,
          ),
          Container(
              constraints: BoxConstraints(maxWidth: 1250, minHeight: 600),
              // color: Colors.blue,
              // width: double.infinity,
              // height: double.infinity,
              child: BlocProvider(
                create: (_) => Final_Bloc(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        // color: Colors.red,
                        height: 50,
                        constraints:
                            BoxConstraints(maxWidth: 1250, maxHeight: 50),
                        child: alltap(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: BlocBuilder<Final_Bloc, mapdataset>(
                            builder: (context, data) {
                              return PageSelectFunc(FnlSelectedTap, data);
                            },
                          ))
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class alltap extends StatelessWidget {
  const alltap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ComBtnBlackBorder(
              sLabel: "TYPE",
              cBg: FnlSelectedTap == 1 ? Colors.black : Colors.transparent,
              cText: FnlSelectedTap == 1 ? Colors.white : null,
              func: () {
                FnlSelectedTap = 1;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 150),
          ComBtnBlackBorder(
              sLabel: "UNIT",
              cBg: FnlSelectedTap == 2 ? Colors.black : Colors.transparent,
              cText: FnlSelectedTap == 2 ? Colors.white : null,
              func: () {
                FnlSelectedTap = 2;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 150),
          ComBtnBlackBorder(
              sLabel: "ITEMs",
              cBg: FnlSelectedTap == 3 ? Colors.black : Colors.transparent,
              cText: FnlSelectedTap == 3 ? Colors.white : null,
              func: () {
                FnlSelectedTap = 3;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 150),
          ComBtnBlackBorder(
              sLabel: "MACHINE NAME",
              cBg: FnlSelectedTap == 4 ? Colors.black : Colors.transparent,
              cText: FnlSelectedTap == 4 ? Colors.white : null,
              func: () {
                FnlSelectedTap = 4;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 150),
          ComBtnBlackBorder(
              sLabel: "METHOD",
              cBg: FnlSelectedTap == 5 ? Colors.black : Colors.transparent,
              cText: FnlSelectedTap == 5 ? Colors.white : null,
              func: () {
                FnlSelectedTap = 5;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 150),
          ComBtnBlackBorder(
              sLabel: "SPECIAL SPEC.",
              cBg: FnlSelectedTap == 6 ? Colors.black : Colors.transparent,
              cText: FnlSelectedTap == 6 ? Colors.white : null,
              func: () {
                FnlSelectedTap = 6;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 150),
          ComBtnBlackBorder(
              sLabel: "CALCULATE",
              cBg: FnlSelectedTap == 7 ? Colors.black : Colors.transparent,
              cText: FnlSelectedTap == 7 ? Colors.white : null,
              func: () {
                FnlSelectedTap = 7;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 150),
        ],
      ),
    );
  }
}

Widget PageSelectFunc(int page, mapdataset data) {
  Widget Pageoutput = TableDummy(pt: "-");

  if (page == 1) {
    Pageoutput = FnlTypeTable(
      data: data,
    );
  } else if (page == 2) {
    Pageoutput = FnlUnitTable(
      data: data,
    );
  } else if (page == 3) {
    Pageoutput = FnlITEMsTable(
      data: data,
    );
  } else if (page == 4) {
    Pageoutput = FnlMachineNameTable(
      data: data,
    );
  } else if (page == 5) {
    Pageoutput = FnlMethodTable(
      data: data,
    );
  } else if (page == 6) {
    Pageoutput = FnlSpeciSPeTable(
      data: data,
    );
  } else if (page == 7) {
    Pageoutput = FnlCalculateTable(
      data: data,
    );
  }

  return Pageoutput;
}

class TableDummy extends StatelessWidget {
  TableDummy({Key? key, required this.pt}) : super(key: key);
  String pt;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("TEST : ${pt}"),
    );
  }
}
