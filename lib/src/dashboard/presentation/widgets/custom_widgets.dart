
import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Row(
        children: [
          HeaderCell(text: "Orders"),
          HeaderCell(text: "Date"),
          HeaderCell(text: "Status"),
          HeaderCell(flex: 2, text: "Total"),
          HeaderCell(text: "Actions"),
        ],
      ),
    );
  }
}

class OrderRow extends StatelessWidget {
  final dynamic order; // Replace `dynamic` with your order model class

  const OrderRow({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TableCell(text: order?.order ?? ""),
        TableCell(text: order?.date ?? ""),
        TableCell(text: order?.status ?? ""),
        TableCell(flex: 2, text: order?.total ?? ""),
        TableCell(text: order?.actions ?? ""),
      ],
    );
  }
}

class HeaderCell extends StatelessWidget {
  final String text;
  final int flex;

  const HeaderCell({super.key, required this.text, this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class TableCell extends StatelessWidget {
  final String text;
  final int flex;

  const TableCell({super.key, required this.text, this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(text),
      ),
    );
  }
}
