import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:certempiree/core/shared/widgets/snakbar.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../data/models/order_data_model.dart';
import '../../../domain/repos/order_repo.dart';
import 'order_events.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderInitEvent, OrderInitialState> {
  final OrderRepo _orderRepo = getIt<OrderRepo>();

  OrderBloc() : super(OrderInitialState()) {
    on<GetOrderEvent>(_getRewards);
  }

  Future<void> _getRewards(
    GetOrderEvent event,
    Emitter<OrderInitialState> emit,
  ) async {
    List<OrderData> orders = [
      OrderData(
        order: "Order #1",
        date: "2023-10-01",
        status: "Pending",
        total: "\$100.00",
        actions: "View",
      ),
      OrderData(
        order: "Order #2",
        date: "2023-10-02",
        status: "Completed",
        total: "\$200.00",
        actions: "View",
      ),
      OrderData(
        order: "Order #1",
        date: "2023-10-01",
        status: "Pending",
        total: "\$100.00",
        actions: "View",
      ),
      OrderData(
        order: "Order #2",
        date: "2023-10-02",
        status: "Completed",
        total: "\$200.00",
        actions: "View",
      ),
      OrderData(
        order: "Order #1",
        date: "2023-10-01",
        status: "Pending",
        total: "\$100.00",
        actions: "View",
      ),
      OrderData(
        order: "Order #2",
        date: "2023-10-02",
        status: "Completed",
        total: "\$200.00",
        actions: "View",
      ),
    ];

    emit(state.copyWith(loading: true, withDrawLoading: false,orders: orders));
    // final res = await _orderRepo.getUserReward(
    //   event.userId,
    //   event.pageSize,
    //   event.pageNumber,
    // );
    // res.when(
    //   onSuccess: (data) {
    //     emit(state.copyWith(loading: false, orders: orders, itemLength: 10));
    //   },
    //   onFailure: (message) {
    //     Snackbar.show(message);
    //     emit(state.copyWith(loading: false, errorMessage: message));
    //   },
    // );
  }
}
