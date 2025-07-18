import 'package:certempiree/core/config/api/api_result.dart';

import '../../../../core/config/api/api_endpoint.dart';
import '../../../../core/config/api/api_manager.dart';
import '../models/get_all_reward_data_model.dart';
import '../models/get_coupon_model.dart';
import '../models/withdraw_reward_model.dart';

class MyRewardDataSrc {
  final ApiManager _apiManager;

  MyRewardDataSrc(this._apiManager);

  Future<ApiResult<APIResponse<GetAllRewardDataModel>>> getUserReward(
    String userId,
    int pageSize,
    int pageNumber,
  ) async {
    final result = await _apiManager.get(
      ApiEndpoint.getUserRewards,
      queryParameters: {
        'UserId': userId,
        "PageNumber": pageNumber,
        "PageSize": pageSize,
      },
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

  Future<ApiResult<APIResponse<WithdrawRewardModel>>> withDrawReward(
    String userId,
    String fileId,
  ) async {
    final result = await _apiManager.post(
      ApiEndpoint.withdrawReward,
      data: {"userId": userId, "fileId": fileId},
    );
    return result.when(
      onSuccess:
          (res) => ApiResult.success(
            APIResponse.fromJson(res, (data) {
              return WithdrawRewardModel.fromJson(res);
            }),
          ),
      onFailure: (message) => ApiResult.failure(message),
    );
  }

  Future<ApiResult<APIResponse<GetCouponModel>>> getCoupon(
    String userId,
    String fileId,
  ) async {
    final result = await _apiManager.post(
      ApiEndpoint.withdrawReward,
      data: {"userId": userId, "fileId": fileId},
    );
    return result.when(
      onSuccess:
          (res) => ApiResult.success(
            APIResponse.fromJson(res, (data) {
              return GetCouponModel.fromJson(res);
            }),
          ),
      onFailure: (message) => ApiResult.failure(message),
    );
  }
}
