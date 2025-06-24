import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order_model.dart';

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
  final OrdersDetails order; // Replace `dynamic` with your order model class

  const OrderRow({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TableCell(text: order.id.toString()),
        TableCell(text: convertDate(order.dateCreated ?? "")),
        TableCell(text: order.status ?? ""),
        TableCell(flex: 2, text: order.total ?? ""),
        TableCell(text: "View"),
      ],
    );
  }

  String convertDate(String isoTimestamp) {
    try {
      final dateTime = DateTime.parse(isoTimestamp);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (_) {
      return '';
    }
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
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class TableCell extends StatelessWidget {
  final String text;
  final int flex;

  const TableCell({super.key, required this.text, this.flex = 1});

  @override
  Widget build(BuildContext context) {
    /// zohaib
    return text == "View"
        ? Container(color: Colors.purple, width: 20, height: 20)
        : Expanded(
          flex: flex,
          child: InkWell(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(text),
            ),
          ),
        );
  }
}
