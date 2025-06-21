import 'package:equatable/equatable.dart';

import '../../../data/models/order_data_model.dart';

class OrderInitialState extends Equatable {
  final List<OrderData>? orders;
  final bool? loading;
  final int? itemLength;

  @override
  List<Object?> get props => [orders, loading, itemLength];

  const OrderInitialState({this.itemLength = 1, this.loading, this.orders});

  OrderInitialState copyWith({
    List<OrderData>? orders,
    bool? loading,
    String? errorMessage,
    int? itemLength,
    bool? withDrawLoading,
  }) {
    return OrderInitialState(
      itemLength: itemLength ?? this.itemLength,
      loading: loading ?? this.loading,
      orders: orders ?? this.orders,
    );
  }
}
