import 'package:certempiree/core/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../simulation/presentation/bloc/download_page_bloc/download_page_bloc.dart';
import '../bloc/order_bloc/order_bloc.dart';
import '../bloc/order_bloc/order_events.dart';
import '../bloc/order_bloc/order_state.dart';
import '../widgets/order_table_view.dart';

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
      GetOrderEvent(pageNumber: 1, pageSize: 10, userId: AppStrings.userId),
    );
    context.read<DownloadPageBloc>().add(
      GetDownloadsEvent(pageNumber: 1, pageSize: 10, userId: AppStrings.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<OrderBloc, OrderInitialState>(
        builder: (context, state) {
          // Return the content directly. The main page will handle scrolling.
          return OrderTableView(orders: state.orders ?? []);
        },
      ),
    );
  }
}
