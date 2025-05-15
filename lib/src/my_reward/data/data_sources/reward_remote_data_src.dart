import 'package:certempiree/core/config/api/api_result.dart';

import '../../../../core/config/api/api_endpoint.dart';
import '../../../../core/config/api/api_manager.dart';
import '../models/get_all_reward_data_model.dart';

class MyRewardDataSrc {
  final ApiManager _apiManager;

  MyRewardDataSrc(this._apiManager);

  Future<ApiResult<APIResponse<GetAllRewardDataModel>>> getUserReward(
    String userId,
  ) async {
    final result = await _apiManager.get(
      ApiEndpoint.getUserRewards,
      queryParameters: {'userId': userId},
    );
    return result.when(
      onSuccess:
          (res) => ApiResult.success(
            APIResponse.fromJson(
              res,
              (data) => GetAllRewardDataModel.fromJson(res),
            ),
          ),
      onFailure: (message) => ApiResult.failure(message),
    );
  }
}
