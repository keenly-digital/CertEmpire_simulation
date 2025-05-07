import 'package:certempiree/core/config/api/api_result.dart';

import '../../../../core/config/api/api_endpoint.dart';
import '../../../../core/config/api/api_manager.dart';

class SimulationDataSrc {
  final ApiManager _apiManager;

  SimulationDataSrc(this._apiManager);

  Future<ApiResult<APIResponse<String>>> getSimulationData(
    String simulationId,
  ) async {
    final result = await _apiManager.get(
      ApiEndpoint.getSimulationData,
      queryParameters: {'simulationId': simulationId},
    );
    return result.when(
      onSuccess:
          (res) => ApiResult.success(
            APIResponse.fromJson(res, (data) => data as String),
          ),
      onFailure: (message) => ApiResult.failure(message),
    );
  }
}
