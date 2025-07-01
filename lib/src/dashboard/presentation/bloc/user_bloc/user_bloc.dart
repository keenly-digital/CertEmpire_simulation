import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../core/res/app_strings.dart';
import '../../../models/user_model.dart';
import 'user_events.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserInitEvent, UserInitialState> {
  UserBloc() : super(UserInitialState()) {
    on<GetUserEvent>(_getUserData);
    on<UpdateUserEvent>(_updateUserData);
  }

  void _getUserData(GetUserEvent event, Emitter<UserInitialState> emit) async {
    final dio = Dio();

    final url =
        '${AppStrings.baseUrl}/wp-json/cwc/v2/customer/${AppStrings.id}';
    final consumerSecret = 'cs_1b64f61e4cf40ae19ab5284143dd19e77cc79620';

    try {
      final response = await dio.get(
        url,
        queryParameters: {'consumer_secret': consumerSecret},
      );
      if (response.statusCode == 200) {
        var data = UserData.fromJson(response.data);

        emit(state.copyWith(userData: data.data, loading: false));
      } else {
        debugPrint('Failed with status: ${response.statusCode}');
        emit(state.copyWith(loading: false, userData: null));
      }
    } catch (e) {
      debugPrint('Request error: $e');
    }
  }

  Future<void> _updateUserData(
    UpdateUserEvent event,
    Emitter<UserInitialState> emit,
  ) async {
    final dio = Dio();
    final consumerSecret = 'cs_1b64f61e4cf40ae19ab5284143dd19e77cc79620';

    final url =
        "${AppStrings.baseUrl}/wp-json/wc/v3/customers/${AppStrings.id}?consumer_key=ck_f6f8767e67544a97e27d0336f31dcf27c882694a&consumer_secret=$consumerSecret";

    try {
      final response = await dio.put(
        url,
        data: {
          "id": event.userInfoData.id,
          "date_created": event.userInfoData.dateCreated?.toIso8601String(),
          "date_created_gmt":
              event.userInfoData.dateCreatedGmt?.toIso8601String(),
          "date_modified": event.userInfoData.dateModified?.toIso8601String(),
          "date_modified_gmt":
              event.userInfoData.dateModifiedGmt?.toIso8601String(),
          "email": event.userInfoData.email,
          "first_name": event.userInfoData.firstName,
          "last_name": event.userInfoData.lastName,
          "role": event.userInfoData.role,
          "username": event.userInfoData.username,
          "is_paying_customer": event.userInfoData.isPayingCustomer,
          "avatar_url": event.userInfoData.avatarUrl,

          "billing": {
            "first_name": event.userInfoData.billing?.firstName,
            "last_name": event.userInfoData.billing?.lastName,
            "company": event.userInfoData.billing?.company,
            "address_1": event.userInfoData.billing?.address1,
            "address_2": event.userInfoData.billing?.address2,
            "city": event.userInfoData.billing?.city,
            "state": event.userInfoData.billing?.state,
            "postcode": event.userInfoData.billing?.postcode,
            "country": event.userInfoData.billing?.country,
            "email":
                event.userInfoData.billing?.email ?? event.userInfoData.email,
            "phone": event.userInfoData.billing?.phone,
          },

          "shipping": {
            "first_name": event.userInfoData.shipping?.firstName,
            "last_name": event.userInfoData.shipping?.lastName,
            "company": event.userInfoData.shipping?.company,
            "address_1": event.userInfoData.shipping?.address1,
            "address_2": event.userInfoData.shipping?.address2,
            "city": event.userInfoData.shipping?.city,
            "state": event.userInfoData.shipping?.state,
            "postcode": event.userInfoData.shipping?.postcode,
            "country": event.userInfoData.shipping?.country,
            "email":
                event.userInfoData.shipping?.email ?? event.userInfoData.email,
            "phone": event.userInfoData.shipping?.phone,
          },

          "meta_data": [
            {
              "key": "selected_currency",
              "value": event.userInfoData.selectedCurrency?.name ?? "USD",
            },
          ],

          "currency_options":
              event.userInfoData.currencyOptions
                  ?.map(
                    (x) => {"code": x.code, "symbol": x.symbol, "name": x.name},
                  )
                  .toList(),

          "selected_currency":
              event.userInfoData.selectedCurrency == null
                  ? null
                  : {
                    "code": event.userInfoData.selectedCurrency?.code,
                    "symbol": event.userInfoData.selectedCurrency?.symbol,
                    "name": event.userInfoData.selectedCurrency?.name,
                  },
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200) {
        UserInfoData userInfoData = UserInfoData.fromJson(response.data);
        emit(state.copyWith(userData: userInfoData, loading: false));
      } else {
        debugPrint('Failed with status: ${response.statusCode}');
        emit(state.copyWith(loading: false, userData: null));
      }
    } catch (e) {
      debugPrint('Request error: $e');
    }
  }

  Future<void> updateUserProfile(
    UserInfoData event,
    // Emitter<UserInitialState> emit,
  ) async {
    final dio = Dio();
    final consumerSecret = 'cs_1b64f61e4cf40ae19ab5284143dd19e77cc79620';

    final url =
        "${AppStrings.baseUrl}/wp-json/wc/v3/customers/${AppStrings.id}?consumer_key=ck_f6f8767e67544a97e27d0336f31dcf27c882694a&consumer_secret=$consumerSecret";

    try {
      final response = await dio.put(
        url,
        data: {
          "email": event.email,
          "first_name": event.firstName,
          "last_name": event.lastName,
          "display_name": event.username,
          "current_password": event.currentPassword ?? "",
          "new_password": event.newPassword ?? "",
          "default_currency": event.selectedCurrency?.name ?? "USD",
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200) {
        UserInfoData userInfoData = UserInfoData.fromJson(response.data);
        emit(state.copyWith(userData: userInfoData, loading: false));
      } else {
        debugPrint('Failed with status: ${response.statusCode}');
        emit(state.copyWith(loading: false, userData: null));
      }
    } catch (e) {
      debugPrint('Request error: $e');
    }
  }
}
