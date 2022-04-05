import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tpk_qc_master/mainBody.dart';
import 'package:tpk_qc_master/widget/common/Loading.dart';

import '../../bloc/BlocEvent/01-incoming.dart';
import '../../bloc/Cubit/Rebuild.dart';
import '../../data/global.dart';
import '../../widget/common/ComBtnBlackBorder.dart';
import 'dummydata.dart';
import 'incoming-01-type.dart';
import 'incoming-02-Unit.dart';
import 'incoming-03-ITEMs.dart';
import 'incoming-04-MachineName.dart';
import 'incoming-05-Method.dart';
import 'incoming-06-SpecialSpec.dart';
import 'incoming-07-Calculate.dart';
import 'incoming-control.dart';

// class TapMainIncomingBody extends StatelessWidget {
//   /// {@macro counter_page}
//   const TapMainIncomingBody({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (_) => Incoming_Bloc(),
//         child: BlocBuilder<Incoming_Bloc, int>(
//           builder: (context, data) {
//             return TapMainIncomingBodyB();
//           },
//         ));
//   }
// }

class TapMainIncomingBody extends StatelessWidget {
  TapMainIncomingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("INCOMING MASTER"),
          SizedBox(
            height: 5,
          ),
          Container(
              constraints: BoxConstraints(maxWidth: 1250, minHeight: 600),
              // color: Colors.blue,
              // width: double.infinity,
              // height: double.infinity,
              child: BlocProvider(
                create: (_) => Incoming_Bloc(),
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
                          child: BlocBuilder<Incoming_Bloc, mapdataset>(
                            builder: (context, data) {
                              return PageSelectFunc(IncSelectedTap, data);
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
              cBg: IncSelectedTap == 1 ? Colors.black : Colors.transparent,
              cText: IncSelectedTap == 1 ? Colors.white : null,
              func: () {
                IncSelectedTap = 1;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 150),
          ComBtnBlackBorder(
              sLabel: "UNIT",
              cBg: IncSelectedTap == 2 ? Colors.black : Colors.transparent,
              cText: IncSelectedTap == 2 ? Colors.white : null,
              func: () {
                IncSelectedTap = 2;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 150),
          ComBtnBlackBorder(
              sLabel: "ITEMs",
              cBg: IncSelectedTap == 3 ? Colors.black : Colors.transparent,
              cText: IncSelectedTap == 3 ? Colors.white : null,
              func: () {
                IncSelectedTap = 3;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 150),
          ComBtnBlackBorder(
              sLabel: "MACHINE NAME",
              cBg: IncSelectedTap == 4 ? Colors.black : Colors.transparent,
              cText: IncSelectedTap == 4 ? Colors.white : null,
              func: () {
                IncSelectedTap = 4;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 150),
          ComBtnBlackBorder(
              sLabel: "METHOD",
              cBg: IncSelectedTap == 5 ? Colors.black : Colors.transparent,
              cText: IncSelectedTap == 5 ? Colors.white : null,
              func: () {
                IncSelectedTap = 5;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 150),
          ComBtnBlackBorder(
              sLabel: "SPECIAL SPEC.",
              cBg: IncSelectedTap == 6 ? Colors.black : Colors.transparent,
              cText: IncSelectedTap == 6 ? Colors.white : null,
              func: () {
                IncSelectedTap = 6;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 150),
          ComBtnBlackBorder(
              sLabel: "CALCULATE",
              cBg: IncSelectedTap == 7 ? Colors.black : Colors.transparent,
              cText: IncSelectedTap == 7 ? Colors.white : null,
              func: () {
                IncSelectedTap = 7;
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
    Pageoutput = IncTypeTable(
      data: data,
    );
  } else if (page == 2) {
    Pageoutput = IncUnitTable(
      data: data,
    );
  } else if (page == 3) {
    Pageoutput = IncITEMsTable(
      data: data,
    );
  } else if (page == 4) {
    Pageoutput = IncMachineNameTable(
      data: data,
    );
  } else if (page == 5) {
    Pageoutput = IncMethodTable(
      data: data,
    );
  } else if (page == 6) {
    Pageoutput = IncSpeciSPeTable(
      data: data,
    );
  } else if (page == 7) {
    Pageoutput = IncCalculateTable(
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
