import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/Cubit/Rebuild.dart';
import '../../data/global.dart';
import '../../styles/TextStyle.dart';
import '../../widget/common/ComInputText.dart';
import '../../widget/common/Easydropdown.dart';
import '../../widget/common/Loading.dart';
import 'incoming-control.dart';

String _searchResult = '';
late BuildContext IncUnitContexttable;

class IncUnitTable extends StatefulWidget {
  IncUnitTable({Key? key, this.data}) : super(key: key);
  List<dataset>? data;

  @override
  _IncUnitTableState createState() => _IncUnitTableState();
}

class _IncUnitTableState extends State<IncUnitTable> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    // context.read<DataSetBloc>().add(GetDataPressed());
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    IncUnitContexttable = context;
    final _MyData _data = _MyData(context, widget.data ?? []);

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
                              IncUnit_masterID = '';
                              IncUnit_Unit = '';
                              IncUnit_Type = '';
                              IncUnit_Desimal = '';
                              _IncUnitConsoleBox();
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
                  IncUnit_Type = data.f01;
                  IncUnit_Unit = data.f02;
                  IncUnit_Desimal = data.f03;
                  IncUnit_masterID = data.f04;
                  _IncUnitConsoleBox();
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

void _IncUnitConsoleBox() {
  showDialog(
    context: IncUnitContexttable,
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
                                IncUnit_Type = input;
                                onLoadingType01_ms(
                                    IncUnitContexttable,
                                    () {},
                                    BlocProvider.of<BlocPageRebuild>(
                                            IncUnitContexttable)
                                        .rebuildPage());
                              },
                              value: IncUnit_Type,
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
                          isContr: undercontrolIncUnit,
                          fnContr: (input) {
                            undercontrolIncUnit = input;
                          },
                          sValue: IncUnit_Unit,
                          returnfunc: (String s) {
                            IncUnit_Unit = s;
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
                                IncUnit_Desimal = input;
                                onLoadingType01_ms(
                                    IncUnitContexttable,
                                    () {},
                                    BlocProvider.of<BlocPageRebuild>(
                                            IncUnitContexttable)
                                        .rebuildPage());
                              },
                              value: IncUnit_Desimal,
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
                          isContr: undercontrolIncUnit,
                          fnContr: (input) {
                            undercontrolIncUnit = input;
                          },
                          sValue: IncUnit_masterID,
                          returnfunc: (String s) {
                            IncUnit_masterID = s;
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
