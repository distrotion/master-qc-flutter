import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tpk_qc_master/widget/common/Advancedropdown.dart';

import '../../bloc/BlocEvent/02-final.dart';
import '../../bloc/Cubit/Rebuild.dart';
import '../../data/global.dart';
import '../../styles/TextStyle.dart';
import '../../widget/common/ComInputText.dart';
import '../../widget/common/Easydropdown.dart';
import '../../widget/common/Loading.dart';
import 'Final-control.dart';

String _searchResult = '';
late BuildContext FnlCalculateContexttable;

class FnlCalculateTable extends StatefulWidget {
  FnlCalculateTable({Key? key, this.data}) : super(key: key);
  mapdataset? data;

  @override
  _FnlCalculateTableState createState() => _FnlCalculateTableState();
}

class _FnlCalculateTableState extends State<FnlCalculateTable> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    // context.read<DataSetBloc>().add(GetDataPressed());
    context.read<Final_Bloc>().add(Final_CALCULATE_flush());
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FnlCalculateContexttable = context;
    final _MyData _data = _MyData(context, widget.data?.set01 ?? []);
    List<dataset> inputdropdown01 = widget.data?.set03 ?? [];
    List<dataset> inputdropdown02 = widget.data?.set02 ?? [];
    List<String> dropdown01 = [""];
    List<String> dropdown02 = [];

    for (int i = 0; i < inputdropdown01.length; i++) {
      dropdown01.add(inputdropdown01[i].f01);
    }
    for (int i = 0; i < inputdropdown02.length; i++) {
      dropdown02.add(inputdropdown02[i].f01);
    }

    print(dropdown02);

    // print(dropdown01);
    // print(dropdown02);

    void _sort<T>(Comparable<T> Function(dataset d) getField, int columnIndex,
        bool ascending) {
      _data._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    return SingleChildScrollView(
      child: SizedBox(
        width: 1200,
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: (value) {
                      setState(() {
                        _searchResult = value;
                      });
                    }),
                trailing: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      controller.clear();
                      _searchResult = '';
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                width: 1200,
                child: PaginatedDataTable(
                  source: _data,
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('CALCULATE'),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // FnlType_TYPE = '';
                              // FnlType_masterID = '';
                              _FnlCalculateConsoleBox(dropdown01, dropdown02);
                            },
                            // style: ButtonStyle(
                            //   backgroundColor:
                            //       MaterialStateProperty.all(Colors.red),
                            // ),

                            child: const Text("NEW"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  columns: [
                    DataColumn(
                        label: const Text('ITEMs'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f01, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('NAME'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f02, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('Formula'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f03, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('masterID'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f04, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('ACTION'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f05, columnIndex, ascending)),
                  ],
                  columnSpacing: 100,
                  horizontalMargin: 10,
                  rowsPerPage: 5,
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  showCheckboxColumn: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// The "soruce" of the table
class _MyData extends DataTableSource {
  // Generate some made-up data
  final BuildContext context;
  late List<dataset> _data;
  late List<dataset> input;
  List<dataset> _data_exp = [];

  int _selectedCount = 0;
  _MyData.empty(this.context) {
    _data = [];
  }
  _MyData(this.context, this.input) {
    _data = input;
    _data_exp = [];

    for (int i = 0; i < _data.length; i++) {
      if (_data[i].f01.toLowerCase().contains(_searchResult) ||
          _data[i].f02.toLowerCase().contains(_searchResult) ||
          _data[i].f03.toLowerCase().contains(_searchResult)) {
        _data_exp.add(_data[i]);
      }
    }
  }

  void _sort<T>(Comparable<T> Function(dataset d) getField, bool ascending) {
    _data_exp.sort((dataset a, dataset b) {
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data_exp.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    final dataset data = _data_exp[index];

    return DataRow.byIndex(index: index,
        // selected: data.selected,
        // onSelectChanged: (value) {
        //   if (data.selected != value) {
        //     //function
        //   }
        // },
        cells: [
          DataCell(Text(data.f01)),
          DataCell(Text(data.f02)),
          DataCell(Text(data.f03)),
          DataCell(Text(data.f04)),
          DataCell(Row(
            children: [
              InkWell(
                onTap: () {
                  print(data.f01);
                },
                child: const Icon(
                  Icons.edit,
                ),
              ),
              InkWell(
                onTap: () {
                  print(data.f02);
                },
                child: const Icon(
                  Icons.delete,
                ),
              )
            ],
          )),
        ]);
  }
}

void _FnlCalculateConsoleBox(List<String> dropdown01, List<String> dropdown02) {
  showDialog(
    context: FnlCalculateContexttable,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Container(
        // color: Colors.blue,
        child: Dialog(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
                height: 500,
                width: 700,
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                // color: Colors.red,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("NAME",
                                            style: TxtStyle(
                                                color: CustomTheme.colorGrey,
                                                fontSize: 8)),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 40,
                                          width: 150,
                                          child: ComInputText(
                                            isContr: undercontrolFnlCalculate,
                                            fnContr: (input) {
                                              undercontrolFnlCalculate = input;
                                            },
                                            sValue: FnlType_CALCULATE,
                                            returnfunc: (String s) {
                                              FnlType_CALCULATE = s;
                                            },
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("AMOUNT PARAMETER",
                                            style: TxtStyle(
                                                color: CustomTheme.colorGrey,
                                                fontSize: 8)),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 40,
                                          // color: Colors.white,
                                          child: EasyDropDown(
                                            listdropdown: const [
                                              "",
                                              "1",
                                              "2",
                                              "3",
                                              "4",
                                              "5"
                                            ],
                                            onChangeinside: (input) {
                                              AmoParaGol = input;
                                              onLoadingType01_ms(
                                                  FnlCalculateContexttable,
                                                  () {},
                                                  BlocProvider.of<
                                                              BlocPageRebuild>(
                                                          FnlCalculateContexttable)
                                                      .rebuildPage());
                                            },
                                            value: AmoParaGol,
                                            width: 150,
                                            height: 40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                // color: Colors.blue,
                                child: PageSelectFunc(
                                    AmoParaGol, dropdown01, dropdown02),
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 600,
                        child: SizedBox(
                          height: 40,
                          width: 150,
                          child: ComInputText(
                            isContr: undercontrolFnlCalculate,
                            fnContr: (input) {
                              undercontrolFnlCalculate = input;
                            },
                            sValue: FnlType_CALCULATE,
                            returnfunc: (String s) {
                              FnlType_CALCULATE = s;
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      );
    },
  );
}

String AmoParaGol = '';

Widget PageSelectFunc(
    String AmoPara, List<String> dropdown01, List<String> dropdown02) {
  Widget Widgetoutput = TableDummy(pt: "-");
  // print(dropdown01);

  if (AmoPara == '1') {
    Widgetoutput = Column(
      children: [
        Container(
          height: 40,
          width: 450,
          // color: Colors.black,
          child: firstpara(dropdown01, dropdown02),
        )
      ],
    );
  } else if (AmoPara == '2') {
    Widgetoutput = Column(
      children: [
        Container(
          height: 40,
          width: 450,
          child: firstpara(dropdown01, dropdown02),
        ),
        Container(
          height: 40,
          width: 450,
          child: secondpara(dropdown01, dropdown02),
        ),
      ],
    );
  } else if (AmoPara == '3') {
    Widgetoutput = Column(
      children: [
        Container(
          height: 40,
          width: 450,
          child: firstpara(dropdown01, dropdown02),
        ),
        Container(
          height: 40,
          width: 450,
          child: secondpara(dropdown01, dropdown02),
        ),
        Container(
            height: 40, width: 450, child: thirdpara(dropdown01, dropdown02)),
      ],
    );
  } else if (AmoPara == '4') {
    Widgetoutput = Column(
      children: [
        Container(
          height: 40,
          width: 450,
          child: firstpara(dropdown01, dropdown02),
        ),
        Container(
          height: 40,
          width: 450,
          child: secondpara(dropdown01, dropdown02),
        ),
        Container(
            height: 40, width: 450, child: thirdpara(dropdown01, dropdown02)),
        Container(
            height: 40, width: 450, child: fourthpara(dropdown01, dropdown02)),
      ],
    );
  } else if (AmoPara == '5') {
    Widgetoutput = Column(
      children: [
        Container(
          height: 40,
          width: 450,
          child: firstpara(dropdown01, dropdown02),
        ),
        Container(
          height: 40,
          width: 450,
          child: secondpara(dropdown01, dropdown02),
        ),
        Container(
            height: 40, width: 450, child: thirdpara(dropdown01, dropdown02)),
        Container(
            height: 40, width: 450, child: fourthpara(dropdown01, dropdown02)),
        Container(
            height: 40, width: 450, child: fivethpara(dropdown01, dropdown02)),
      ],
    );
  }

  return Widgetoutput;
}

class TableDummy extends StatelessWidget {
  TableDummy({Key? key, required this.pt}) : super(key: key);
  String pt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text("${pt}"),
    );
  }
}

Widget firstpara(List<String> dropdown01, List<String> dropdown02) {
  List<String> ddtest = [];
  for (var i = 0; i < 5; i++) {
    ddtest.add(dropdown01[0].toString());
  }
  // print(ddtest);

  Widget Widgetoutput = Row(
    children: [
      Container(
        width: 150,
        // color: Colors.red,
        child: SizedBox(
          height: 40,
          width: 150,
          child: ComInputText(
            isContr: undercontrolFnlCalculate,
            fnContr: (input) {
              undercontrolFnlCalculate = input;
            },
            sValue: FnlType_CALCULATE,
            returnfunc: (String s) {
              FnlType_CALCULATE = s;
            },
          ),
        ),
      ),
      Container(
        width: 150,
        // color: Colors.blueAccent,
        child: SizedBox(
          height: 40,
          // color: Colors.white,
          child: EasyDropDown(
            listdropdown: const [
              "",
              "DYNAMIC",
              "CONSTANT",
            ],
            onChangeinside: (input) {
              paraTypeA1 = "";
              paraType1 = input;
              if (input == 'DYNAMIC') {
                DropDown1st01 = dropdown01;
              } else if (input == 'CONSTANT') {
                DropDown1st01 = dropdown02;
              }
              onLoadingType01_ms(
                  FnlCalculateContexttable,
                  () {},
                  BlocProvider.of<BlocPageRebuild>(FnlCalculateContexttable)
                      .rebuildPage());
            },
            value: paraType1,
            width: 150,
            height: 40,
          ),
        ),
      ),
      Container(
        width: 150,
        child: EasyDropDown(
          listdropdown: DropDown1st01,
          onChangeinside: (input) {
            // print(input);
            paraTypeA1 = input;
            onLoadingType01_ms(
                FnlCalculateContexttable,
                () {},
                BlocProvider.of<BlocPageRebuild>(FnlCalculateContexttable)
                    .rebuildPage());
          },
          value: paraTypeA1,
          width: 150,
          height: 40,
        ),
      )
    ],
  );

  return Widgetoutput;
}

Widget secondpara(List<String> dropdown01, List<String> dropdown02) {
  Widget Widgetoutput = Row(
    children: [
      Container(
        width: 150,
        child: SizedBox(
          height: 40,
          width: 150,
          child: ComInputText(
            isContr: undercontrolFnlCalculate,
            fnContr: (input) {
              undercontrolFnlCalculate = input;
            },
            sValue: FnlType_CALCULATE,
            returnfunc: (String s) {
              FnlType_CALCULATE = s;
            },
          ),
        ),
      ),
      Container(
        width: 150,
        child: EasyDropDown(
          listdropdown: const [
            "",
            "DYNAMIC",
            "CONSTANT",
          ],
          onChangeinside: (input) {
            paraTypeA2 = "";
            paraType2 = input;
            if (input == 'DYNAMIC') {
              DropDown2nd01 = dropdown01;
            } else if (input == 'CONSTANT') {
              DropDown2nd01 = dropdown02;
            }
            onLoadingType01_ms(
                FnlCalculateContexttable,
                () {},
                BlocProvider.of<BlocPageRebuild>(FnlCalculateContexttable)
                    .rebuildPage());
          },
          value: paraType2,
          width: 150,
          height: 40,
        ),
      ),
      Container(
        width: 150,
        child: EasyDropDown(
          listdropdown: DropDown2nd01,
          onChangeinside: (input) {
            // print(input);
            paraTypeA2 = input;
            onLoadingType01_ms(
                FnlCalculateContexttable,
                () {},
                BlocProvider.of<BlocPageRebuild>(FnlCalculateContexttable)
                    .rebuildPage());
          },
          value: paraTypeA2,
          width: 150,
          height: 40,
        ),
      )
    ],
  );

  return Widgetoutput;
}

Widget thirdpara(List<String> dropdown01, List<String> dropdown02) {
  Widget Widgetoutput = Row(
    children: [
      Container(
        width: 150,
        child: SizedBox(
          height: 40,
          width: 150,
          child: ComInputText(
            isContr: undercontrolFnlCalculate,
            fnContr: (input) {
              undercontrolFnlCalculate = input;
            },
            sValue: FnlType_CALCULATE,
            returnfunc: (String s) {
              FnlType_CALCULATE = s;
            },
          ),
        ),
      ),
      Container(
        width: 150,
        child: EasyDropDown(
          listdropdown: const [
            "",
            "DYNAMIC",
            "CONSTANT",
          ],
          onChangeinside: (input) {
            paraTypeA3 = "";
            paraType3 = input;
            if (input == 'DYNAMIC') {
              DropDown3th01 = dropdown01;
            } else if (input == 'CONSTANT') {
              DropDown3th01 = dropdown02;
            }
            onLoadingType01_ms(
                FnlCalculateContexttable,
                () {},
                BlocProvider.of<BlocPageRebuild>(FnlCalculateContexttable)
                    .rebuildPage());
          },
          value: paraType3,
          width: 150,
          height: 40,
        ),
      ),
      Container(
        width: 150,
        child: EasyDropDown(
          listdropdown: DropDown3th01,
          onChangeinside: (input) {
            // print(input);
            paraTypeA3 = input;
            onLoadingType01_ms(
                FnlCalculateContexttable,
                () {},
                BlocProvider.of<BlocPageRebuild>(FnlCalculateContexttable)
                    .rebuildPage());
          },
          value: paraTypeA3,
          width: 150,
          height: 40,
        ),
      )
    ],
  );

  return Widgetoutput;
}

Widget fourthpara(List<String> dropdown01, List<String> dropdown02) {
  Widget Widgetoutput = Row(
    children: [
      Container(
        width: 150,
        child: SizedBox(
          height: 40,
          width: 150,
          child: ComInputText(
            isContr: undercontrolFnlCalculate,
            fnContr: (input) {
              undercontrolFnlCalculate = input;
            },
            sValue: FnlType_CALCULATE,
            returnfunc: (String s) {
              FnlType_CALCULATE = s;
            },
          ),
        ),
      ),
      Container(
        width: 150,
        child: EasyDropDown(
          listdropdown: const [
            "",
            "DYNAMIC",
            "CONSTANT",
          ],
          onChangeinside: (input) {
            paraTypeA4 = "";
            paraType4 = input;
            if (input == 'DYNAMIC') {
              DropDown4th01 = dropdown01;
            } else if (input == 'CONSTANT') {
              DropDown4th01 = dropdown02;
            }
            onLoadingType01_ms(
                FnlCalculateContexttable,
                () {},
                BlocProvider.of<BlocPageRebuild>(FnlCalculateContexttable)
                    .rebuildPage());
          },
          value: paraType4,
          width: 150,
          height: 40,
        ),
      ),
      Container(
        width: 150,
        child: EasyDropDown(
          listdropdown: DropDown4th01,
          onChangeinside: (input) {
            // print(input);
            paraTypeA4 = input;
            onLoadingType01_ms(
                FnlCalculateContexttable,
                () {},
                BlocProvider.of<BlocPageRebuild>(FnlCalculateContexttable)
                    .rebuildPage());
          },
          value: paraTypeA4,
          width: 150,
          height: 40,
        ),
      )
    ],
  );

  return Widgetoutput;
}

Widget fivethpara(List<String> dropdown01, List<String> dropdown02) {
  Widget Widgetoutput = Row(
    children: [
      Container(
        width: 150,
        child: SizedBox(
          height: 40,
          width: 150,
          child: ComInputText(
            isContr: undercontrolFnlCalculate,
            fnContr: (input) {
              undercontrolFnlCalculate = input;
            },
            sValue: FnlType_CALCULATE,
            returnfunc: (String s) {
              FnlType_CALCULATE = s;
            },
          ),
        ),
      ),
      Container(
        width: 150,
        child: EasyDropDown(
          listdropdown: const [
            "",
            "DYNAMIC",
            "CONSTANT",
          ],
          onChangeinside: (input) {
            paraTypeA5 = "";
            paraType5 = input;
            if (input == 'DYNAMIC') {
              DropDown5th01 = dropdown01;
            } else if (input == 'CONSTANT') {
              DropDown5th01 = dropdown02;
            }
            onLoadingType01_ms(
                FnlCalculateContexttable,
                () {},
                BlocProvider.of<BlocPageRebuild>(FnlCalculateContexttable)
                    .rebuildPage());
          },
          value: paraType5,
          width: 150,
          height: 40,
        ),
      ),
      Container(
        width: 150,
        child: EasyDropDown(
          listdropdown: DropDown5th01,
          onChangeinside: (input) {
            // print(input);
            paraTypeA5 = input;
            onLoadingType01_ms(
                FnlCalculateContexttable,
                () {},
                BlocProvider.of<BlocPageRebuild>(FnlCalculateContexttable)
                    .rebuildPage());
          },
          value: paraTypeA5,
          width: 150,
          height: 40,
        ),
      )
    ],
  );

  return Widgetoutput;
}
