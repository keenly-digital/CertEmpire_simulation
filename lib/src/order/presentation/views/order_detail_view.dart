import 'package:certempiree/src/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:certempiree/src/order/presentation/bloc/order_bloc/order_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailView extends StatelessWidget {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    var purple = Colors.deepPurple[800]!;

    return BlocBuilder<OrderBloc, OrderInitialState>(
      builder: (context, state) {


      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [

            _buildOrderInfo(purple),
            const SizedBox(height: 24),
            _buildDownloadsSection(purple),
            const SizedBox(height: 32),
            _buildOrderDetailsSection(),
            const SizedBox(height: 32),
            _buildOrderAgainButton(purple),
          ],
        ),
      );
    },);
  }
}

  Widget _buildOrderInfo(Color purple) {
    return Text.rich(
      TextSpan(
        text: 'Order #41383 ',
        children: [
          TextSpan(
            text: 'was placed on ',
            style: const TextStyle(color: Colors.black),
          ),
          const TextSpan(
            text: 'June 24, 2025 ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text: 'and is currently ',
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: 'Completed.',
            style: TextStyle(color: purple, fontWeight: FontWeight.bold),
          ),
        ],
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildDownloadsSection(Color purple) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Downloads', style: TextStyle(fontSize: 20, color: purple, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(3),
          },
          border: TableBorder.all(color: Colors.grey),
          children: [
            _buildTableRow(
              isHeader: true,
              values: ['Product', 'Downloads remaining', 'Expires', 'Download'],
            ),
            _buildTableRow(
              values: [
                'Microsoft Dynamics MB-330 Exam Dumps 2025',
                '10',
                'December 21, 2025',
                '',
              ],
              buttons: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: purple),
                  onPressed: () {},
                  child: const Text('MB 330 Dumps'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: purple),
                  onPressed: () {},
                  child: const Text('Practice Online'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order details',
          style: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(6),
            1: FlexColumnWidth(2),
          },
          border: TableBorder.all(color: Colors.grey),
          children: const [
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Product', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Microsoft Dynamics MB-330 Exam Dumps 2025 × 1'),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('26,00 €'),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Subtotal:'),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('26,00 €'),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Payment method:'),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Visa credit card - 0000'),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Total:'),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('26,00 € EUR'),
              ),
            ]),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderAgainButton(Color purple) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: purple,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        onPressed: () {},
        child: const Text('Order again'),
      ),
    );
  }

  TableRow _buildTableRow({required List<String> values, bool isHeader = false, List<Widget>? buttons}) {
    return TableRow(
      children: values.asMap().entries.map((entry) {
        final index = entry.key;
        final value = entry.value;
        if (index == values.length - 1 && buttons != null) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(children: buttons),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: isHeader
                ? const TextStyle(fontWeight: FontWeight.bold)
                : const TextStyle(fontSize: 14),
          ),
        );
      }).toList(),
    );
  }

