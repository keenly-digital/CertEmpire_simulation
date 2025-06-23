import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/res/app_strings.dart';
import '../../../order/presentation/bloc/order_bloc/order_bloc.dart';
import '../../../order/presentation/bloc/order_bloc/order_events.dart';
import '../../../order/presentation/bloc/order_bloc/order_state.dart';
import '../widgets/download/custom_widgets.dart';

class DownloadMainView extends StatefulWidget {
  const DownloadMainView({super.key});

  @override
  State<DownloadMainView> createState() => _DownloadMainViewState();
}

class _DownloadMainViewState extends State<DownloadMainView> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(
      GetOrderEvent(pageNumber: 1, pageSize: 10, userId: AppStrings.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const DownloadHeader(),
            BlocBuilder<OrderBloc, OrderInitialState>(
              builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.orders?.length ?? 0,
                    itemBuilder: (context, index) {
                      final order = state.orders?[index];
                      return DownloadRow(order: order);
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
