import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tpk_qc_master/mainBody.dart';

import '../../bloc/Cubit/Rebuild.dart';
import '../../widget/common/ComBtnBlackBorder.dart';
import 'dummydata.dart';
import 'incoming-01-type.dart';
import 'incoming-02-Unit.dart';
import 'incoming-03-ITEMs.dart';
import 'incoming-04-MachineName.dart';
import 'incoming-05-Method.dart';
import 'incoming-06-SpecialSpec.dart';
import 'incoming-control.dart';

class TapMainIncomingBody extends StatelessWidget {
  const TapMainIncomingBody({Key? key}) : super(key: key);

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
                      child: PageSelectFunc(IncSelectedTap),
                    )
                  ],
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
              nWidth: 200),
          ComBtnBlackBorder(
              sLabel: "UNIT",
              cBg: IncSelectedTap == 2 ? Colors.black : Colors.transparent,
              cText: IncSelectedTap == 2 ? Colors.white : null,
              func: () {
                IncSelectedTap = 2;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 200),
          ComBtnBlackBorder(
              sLabel: "ITEMs",
              cBg: IncSelectedTap == 3 ? Colors.black : Colors.transparent,
              cText: IncSelectedTap == 3 ? Colors.white : null,
              func: () {
                IncSelectedTap = 3;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 200),
          ComBtnBlackBorder(
              sLabel: "MACHINE NAME",
              cBg: IncSelectedTap == 4 ? Colors.black : Colors.transparent,
              cText: IncSelectedTap == 4 ? Colors.white : null,
              func: () {
                IncSelectedTap = 4;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 200),
          ComBtnBlackBorder(
              sLabel: "METHOD",
              cBg: IncSelectedTap == 5 ? Colors.black : Colors.transparent,
              cText: IncSelectedTap == 5 ? Colors.white : null,
              func: () {
                IncSelectedTap = 5;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 200),
          ComBtnBlackBorder(
              sLabel: "SPECIAL SPEC.",
              cBg: IncSelectedTap == 6 ? Colors.black : Colors.transparent,
              cText: IncSelectedTap == 6 ? Colors.white : null,
              func: () {
                IncSelectedTap = 6;
                BlocProvider.of<BlocPageRebuild>(context).rebuildPage();
              },
              nWidth: 200),
        ],
      ),
    );
  }
}

Widget PageSelectFunc(int page) {
  Widget Pageoutput = TableDummy(pt: "-");

  if (page == 1) {
    Pageoutput = IncTypeTable(
      data: TypeDataDS,
    );
  } else if (page == 2) {
    Pageoutput = IncUnitTable(
      data: UnitDataDS,
    );
  } else if (page == 3) {
    Pageoutput = IncITEMsTable(
      data: ITEMsDataDS,
    );
  } else if (page == 4) {
    Pageoutput = IncMachineNameTable(
      data: MachineDataDS,
    );
  } else if (page == 5) {
    Pageoutput = IncMethodTable(
      data: MethodeDataDS,
    );
  } else if (page == 6) {
    Pageoutput = IncSpeciSPeTable(
      data: SPecDataDS,
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
