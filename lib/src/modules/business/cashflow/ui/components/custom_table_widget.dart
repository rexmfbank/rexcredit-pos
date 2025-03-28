import 'package:flutter/material.dart';

class CustomTableWidget extends StatelessWidget {
  final List<Map<String, String>> data;

  const CustomTableWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('#')),
        DataColumn(label: Text('Items')),
        DataColumn(label: Text('Qty')),
        DataColumn(label: Text('Price')),
      ],
      rows: List<DataRow>.generate(
        data.length,
        (index) => DataRow(
          cells: [
            DataCell(Text(data[index]['number']!)),
            DataCell(Text(data[index]['items']!)),
            DataCell(Text(data[index]['qty']!)),
            DataCell(Text(data[index]['price']!)),
          ],
        ),
      ),
    );
  }
}
