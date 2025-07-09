import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../core/res/app_strings.dart';
import '../../../../../core/utils/log_util.dart';
import '../../models/order_model.dart';
import 'order_events.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderInitEvent, OrderInitialState> {
  OrderBloc() : super(OrderInitialState()) {
    on<GetOrderEvent>(_getRewards);
  }

  Future<void> _getRewards(
    GetOrderEvent event,
    Emitter<OrderInitialState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    final dio = Dio();

    final url =
        '${AppStrings.baseUrl}/wp-json/cwc/v2/orders?customer=${AppStrings.id}';
    try {
      final response = await dio.get(
        url,
        queryParameters: {'consumer_secret': AppStrings.consumerSecret},
      );
      if (response.statusCode == 200) {
        var data = OrderDataModel.fromJson(response.data);

        emit(state.copyWith(orders: data.data, loading: false));
        LogUtil.debug("ewqoiueiwqueoiuwq ${data.toJson()}");
      } else {
        debugPrint('Failed with status: ${response.statusCode}');
        emit(state.copyWith(loading: false, orders: null));
      }
    } catch (e) {
      debugPrint('Request error: $e');
    }
  }
}
