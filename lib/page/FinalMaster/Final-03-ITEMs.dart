import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/02-final.dart';
import '../../data/global.dart';

String _searchResult = '';

class FnlITEMsTable extends StatefulWidget {
  FnlITEMsTable({Key? key, this.data}) : super(key: key);
  mapdataset? data;

  @override
  _FnlITEMsTableState createState() => _FnlITEMsTableState();
}

class _FnlITEMsTableState extends State<FnlITEMsTable> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    context.read<Final_Bloc>().add(Final_ITEMs_flush());
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  header: const Text('Table Master'),
                  columns: [
                    DataColumn(
                        label: const Text('TYPE'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f01, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('ITEMs'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f02, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('REsult Format'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f03, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('Graph Type'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f04, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('Graph Intersec'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f05, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('masterID'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f06, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('ACTION'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f07, columnIndex, ascending)),
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
          _data[i].f04.toLowerCase().contains(_searchResult) ||
          _data[i].f05.toLowerCase().contains(_searchResult)) {
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
          DataCell(Text(data.f05)),
          DataCell(Text(data.f06)),
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
