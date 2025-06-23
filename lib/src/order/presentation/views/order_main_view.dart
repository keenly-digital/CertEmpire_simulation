import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:certempiree/core/res/app_strings.dart';
import '../bloc/order_bloc/order_bloc.dart';
import '../bloc/order_bloc/order_events.dart';
import '../bloc/order_bloc/order_state.dart';
import '../widgets/custom_widgets.dart';

class OrderMainView extends StatefulWidget {
  const OrderMainView({super.key});

  @override
  State<OrderMainView> createState() => _OrderMainViewState();
}

class _OrderMainViewState extends State<OrderMainView> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(
      GetOrderEvent(
        pageNumber: 1,
        pageSize: 10,
        userId: AppStrings.userId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const OrderHeader(),
            BlocBuilder<OrderBloc, OrderInitialState>(
              builder: (context, state) {
                final orders = state.orders ?? [];
                return Expanded(
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return OrderRow(order: orders[index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
