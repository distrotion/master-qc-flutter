import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';

class InspSTdFinalTableBUFFER extends StatelessWidget {
  const InspSTdFinalTableBUFFER({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InspSTdFinalTable();
  }
}

String _searchResult = '';

class InspSTdFinalTable extends StatefulWidget {
  InspSTdFinalTable({Key? key, this.data}) : super(key: key);
  List<dataset>? data;

  @override
  _InspSTdFinalTableState createState() => _InspSTdFinalTableState();
}

class _InspSTdFinalTableState extends State<InspSTdFinalTable> {
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
            // Card(
            //   child: ListTile(
            //     leading: const Icon(Icons.search),
            //     title: TextField(
            //         controller: controller,
            //         decoration: const InputDecoration(
            //             hintText: 'Search', border: InputBorder.none),
            //         onChanged: (value) {
            //           setState(() {
            //             _searchResult = value;
            //           });
            //         }),
            //     trailing: IconButton(
            //       icon: const Icon(Icons.cancel),
            //       onPressed: () {
            //         setState(() {
            //           controller.clear();
            //           _searchResult = '';
            //         });
            //       },
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                width: 1200,
                child: PaginatedDataTable(
                  source: _data,
                  header: const Text('FINAL'),
                  columns: [
                    DataColumn(
                        label: const Text('SEQ.'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f01, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('ITEMs'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f02, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('S.C.MARK'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f03, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('DOCUMENT'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f04, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('METHOD'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f05, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('LOAD'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f06, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('GT'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f07, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('SPECIFICATIONve'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f08, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('UNIT'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f09, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('CONv.From'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f10, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('POSITION'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f11, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('PSC'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f12, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('Frequency'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f13, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('Remark'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f14, columnIndex, ascending)),
                    DataColumn(
                        label: const Text('ACTION'),
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>(
                                (dataset d) => d.f15, columnIndex, ascending)),
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
    _data_exp = input;
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
          DataCell(Text(data.f07)),
          DataCell(Text(data.f08)),
          DataCell(Text(data.f09)),
          DataCell(Text(data.f10)),
          DataCell(Text(data.f11)),
          DataCell(Text(data.f12)),
          DataCell(Text(data.f13)),
          DataCell(Text(data.f14)),
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
