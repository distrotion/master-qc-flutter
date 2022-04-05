import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/02-final.dart';
import '../../bloc/Cubit/Rebuild.dart';
import '../../data/global.dart';
import '../../styles/TextStyle.dart';
import '../../widget/common/ComInputText.dart';
import '../../widget/common/Easydropdown.dart';
import '../../widget/common/Loading.dart';
import 'Final-control.dart';

String _searchResult = '';
late BuildContext FnlUnitContexttable;

class FnlUnitTable extends StatefulWidget {
  FnlUnitTable({Key? key, this.data}) : super(key: key);
  mapdataset? data;

  @override
  _FnlUnitTableState createState() => _FnlUnitTableState();
}

class _FnlUnitTableState extends State<FnlUnitTable> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    context.read<Final_Bloc>().add(Final_UNIT_flush());
    // Future.delayed(Duration(milliseconds: 100)).then((valueFuture) =>
    //     context.read<Fnloming_Bloc>().add(Fnloming_UNIT_flush()));
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FnlUnitContexttable = context;
    final _MyData _data = _MyData(context, widget.data?.set01 ?? []);

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
                      const Text('UNIT'),
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
                              FnlUnit_masterID = '';
                              FnlUnit_Unit = '';
                              FnlUnit_Type = '';
                              FnlUnit_Desimal = '';
                              _FnlUnitConsoleBox();
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
                        label: const Text('TYPE'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f01, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('UNIT'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f02, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('DESIMAL'),
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
          _data[i].f03.toLowerCase().contains(_searchResult) ||
          _data[i].f04.toLowerCase().contains(_searchResult)) {
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
                  FnlUnit_Type = data.f01;
                  FnlUnit_Unit = data.f02;
                  FnlUnit_Desimal = data.f03;
                  FnlUnit_masterID = data.f04;
                  _FnlUnitConsoleBox();
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

void _FnlUnitConsoleBox() {
  showDialog(
    context: FnlUnitContexttable,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Container(
        // color: Colors.blue,
        child: Dialog(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
                height: 100,
                width: 700,
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 150,
                            child: Text("TYPE",
                                style: TxtStyle(
                                    color: CustomTheme.colorGrey,
                                    fontSize: 10)),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            width: 150,
                            height: 35,
                            child: EasyDropDown(
                              listdropdown: ["", "Attribute", "length"],
                              onChangeinside: (input) {
                                FnlUnit_Type = input;
                                onLoadingType01_ms(
                                    FnlUnitContexttable,
                                    () {},
                                    BlocProvider.of<BlocPageRebuild>(
                                            FnlUnitContexttable)
                                        .rebuildPage());
                              },
                              value: FnlUnit_Type,
                              width: 150,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 100,
                        height: 60,
                        child: ComInputText(
                          sLabel: "UNIT",
                          isContr: undercontrolFnlUnit,
                          fnContr: (input) {
                            undercontrolFnlUnit = input;
                          },
                          sValue: FnlUnit_Unit,
                          returnfunc: (String s) {
                            FnlUnit_Unit = s;
                          },
                        ),
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 100,
                            child: Text("DESIMAL",
                                style: TxtStyle(
                                    color: CustomTheme.colorGrey,
                                    fontSize: 10)),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            width: 100,
                            height: 35,
                            child: EasyDropDown(
                              listdropdown: ["", "0", "1", "2", "3", "4", "5"],
                              onChangeinside: (input) {
                                FnlUnit_Desimal = input;
                                onLoadingType01_ms(
                                    FnlUnitContexttable,
                                    () {},
                                    BlocProvider.of<BlocPageRebuild>(
                                            FnlUnitContexttable)
                                        .rebuildPage());
                              },
                              value: FnlUnit_Desimal,
                              width: 100,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 200,
                        height: 60,
                        child: ComInputText(
                          isEnabled: false,
                          sLabel: "masterID",
                          isContr: undercontrolFnlUnit,
                          fnContr: (input) {
                            undercontrolFnlUnit = input;
                          },
                          sValue: FnlUnit_masterID,
                          returnfunc: (String s) {
                            FnlUnit_masterID = s;
                          },
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            width: 150,
                            height: 42,
                          ),
                          SizedBox(
                            width: 150,
                            height: 38,
                            child: ElevatedButton(
                              onPressed: () {},
                              // style: ButtonStyle(
                              //   backgroundColor:
                              //       MaterialStateProperty.all(Colors.red),
                              // ),
                              child: const Text("UPDATE"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ),
      );
    },
  );
}
