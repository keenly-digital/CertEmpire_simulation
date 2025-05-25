import 'dart:convert';

import '../../../../core/config/api/api_endpoint.dart';
import '../../../../core/config/api/api_manager.dart';
import '../../../../core/config/api/api_result.dart';
import '../models/my_task_model.dart';
import '../models/vote_task_param_model.dart';
import '../models/vote_task_res_model.dart';

class MyTaskDataSrc {
  final ApiManager _apiManager;

  MyTaskDataSrc(this._apiManager);

  Future<ApiResult<APIResponse<GetAllTaskModel>>> getMyTask(
    String userId,
    int pageNumber,
    int pageSize,
  ) async {
    final result = await _apiManager.get(
      ApiEndpoint.getAllTasks,
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
              (data) => (GetAllTaskModel.fromJson(res)),
            ),
          ),
      onFailure: (message) => ApiResult.failure(message),
    );
  }

  Future<ApiResult<APIResponse<VoteTaskResModel>>> voteTask(
    VoteTaskParamModel voteTaskParamModel,
  ) async {
    final result = await _apiManager.post(
      ApiEndpoint.submitVote,
      data: jsonEncode(voteTaskParamModel.toJson()),
    );
    return result.when(
      onSuccess:
          (res) => ApiResult.success(
            APIResponse.fromJson(
              res,
              (data) => (VoteTaskResModel.fromJson(res)),
            ),
          ),
      onFailure: (message) => ApiResult.failure(message),
    );
  }
}
