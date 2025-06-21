import 'package:certempiree/core/config/api/api_result.dart';

import '../../../../core/config/api/api_endpoint.dart';
import '../../../../core/config/api/api_manager.dart';
import '../models/order_data_model.dart';

class OrderDataSrc {
  final ApiManager _apiManager;

  OrderDataSrc(this._apiManager);

  Future<ApiResult<APIResponse<OrderModel>>> getUserReward(
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
              (data) => OrderModel.fromJson(res),
            ),
          ),
      onFailure: (message) => ApiResult.failure(message),
    );
  }
}
