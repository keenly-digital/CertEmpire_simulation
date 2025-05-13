import 'package:certempiree/core/config/api/api_result.dart';
import 'package:certempiree/src/report_history/data/models/get_all_reports.dart';

import '../../../../core/config/api/api_endpoint.dart';
import '../../../../core/config/api/api_manager.dart';
import '../../../report_history/data/models/view_reason_model.dart';

class MyRewardDataSrc {
  final ApiManager _apiManager;

  MyRewardDataSrc(this._apiManager);

  Future<ApiResult<APIResponse<ViewReportReason>>> getReportReason(
    String reportId,
  ) async {
    final result = await _apiManager.get(
      ApiEndpoint.viewRejectReason,
      queryParameters: {'ReportId': reportId},
    );
    return result.when(
      onSuccess:
          (res) => ApiResult.success(
            APIResponse.fromJson(res, (data) => ViewReportReason.fromJson(res)),
          ),
      onFailure: (message) => ApiResult.failure(message),
    );
  }
}
