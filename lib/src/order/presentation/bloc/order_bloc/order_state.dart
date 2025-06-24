import 'package:equatable/equatable.dart';

import '../../models/order_model.dart';

class OrderInitialState extends Equatable {
  final List<OrdersDetails>? orders;
  final bool? loading;
  final int? itemLength;

  @override
  List<Object?> get props => [orders, loading, itemLength];

  const OrderInitialState({this.itemLength = 1, this.loading, this.orders});

  OrderInitialState copyWith({
    List<OrdersDetails>? orders,
    bool? loading,
    int? itemLength,
  }) {
    return OrderInitialState(
      itemLength: itemLength ?? this.itemLength,
      loading: loading ?? this.loading,
      orders: orders ?? this.orders,
    );
  }
}
