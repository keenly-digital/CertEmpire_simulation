import 'package:bloc/bloc.dart';
import 'package:certempiree/core/utils/log_util.dart';
import 'package:dio/dio.dart';

import '../../../../../core/res/app_strings.dart';
import '../../../models/user_model.dart';
import 'user_events.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserInitEvent, UserInitialState> {
  UserBloc() : super(UserInitialState()) {
    on<GetUserEvent>(_getUserData);
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
        emit(state.copyWith(userData: data, loading: false));
        LogUtil.debug("sadas asdklj ${data.toJson()}");
      } else {
        print('Failed with status: ${response.statusCode}');
        emit(state.copyWith(loading: false, userData: null));
      }
    } catch (e) {
      print('Request error: $e');
    }
  }
}
