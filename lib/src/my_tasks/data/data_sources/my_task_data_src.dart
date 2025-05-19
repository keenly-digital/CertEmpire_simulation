import '../../../../core/config/api/api_endpoint.dart';
import '../../../../core/config/api/api_manager.dart';
import '../../../../core/config/api/api_result.dart';
import '../models/my_task_model.dart';

class MyTaskDataSrc {
  final ApiManager _apiManager;

  MyTaskDataSrc(this._apiManager);

  Future<ApiResult<APIResponse<GetAllTaskModel>>> getMyTask(
    String userId,
  ) async {
    final result = await _apiManager.get(
      ApiEndpoint.getAllTasks,
      queryParameters: {'userId': userId},
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
}
