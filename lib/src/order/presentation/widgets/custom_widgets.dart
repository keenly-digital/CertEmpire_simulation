import 'package:certempiree/core/config/theme/app_colors.dart';
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
  final OrdersDetails order;

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
      return DateFormat('MMMM d, yyyy').format(dateTime);
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
    return text == "View"
        ? Container(
          // Button styling
          decoration: BoxDecoration(
            color: AppColors.themeBlue, // Use your exact blue/purple
            borderRadius: BorderRadius.circular(1),
          ),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
          child: const Text(
            "View",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        )
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
