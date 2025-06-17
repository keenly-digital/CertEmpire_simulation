import 'package:certempiree/core/config/api/api_result.dart';
import 'package:certempiree/src/simulation/data/models/submit_report_model.dart';

import '../../../../core/config/api/api_endpoint.dart';
import '../../../../core/config/api/api_manager.dart';
import '../models/file_content_model.dart';
import '../models/report_ans_param_model.dart';
import '../models/submit_report_param.dart';

class SimulationDataSrc {
  final ApiManager _apiManager;

  SimulationDataSrc(this._apiManager);

  Future<ApiResult<APIResponse<FileContent>>> getSimulationData(
    String fileId,
    int pageNumber,
  ) async {

    final result = await _apiManager.get(
      ApiEndpoint.getSimulationData,
      queryParameters: {'fileId': fileId, 'pageNumber': pageNumber},
    );
    return result.when(
      onSuccess:
          (res) => ApiResult.success(
            APIResponse.fromJson(res, (data) => FileContent.fromJson(data)),
          ),
      onFailure: (message) => ApiResult.failure(message),
    );
  }

  Future<ApiResult<APIResponse<SubmitQuestionReportModel>>> reportQuestion(
    SubmitQuestionReportParam submitQuestionReportParam,
  ) async {
    final result = await _apiManager.post(
      ApiEndpoint.reportQuestion,
      data: submitQuestionReportParam.toJson(),
    );

    return result.when(
      onSuccess:
          (res) => ApiResult.success(
            APIResponse.fromJson(
              res,
              (data) => SubmitQuestionReportModel.fromJson(res),
            ),
          ),
      onFailure: (message) => ApiResult.failure(message),
    );
  }

  Future<ApiResult<APIResponse<SubmitQuestionReportModel>>> reportExplanation(
    SubmitQuestionReportParam submitQuestionReportParam,
  ) async {
    final result = await _apiManager.post(
      ApiEndpoint.reportQuestion,
      data: submitQuestionReportParam.toJson(),
    );

    return result.when(
      onSuccess:
          (res) => ApiResult.success(
            APIResponse.fromJson(
              res,
              (data) => SubmitQuestionReportModel.fromJson(res),
            ),
          ),
      onFailure: (message) => ApiResult.failure(message),
    );
  }

  Future<ApiResult<APIResponse<SubmitQuestionReportModel>>> reportAnswer(
    ReportAnsParamsModel submitQuestionReportParam,
  ) async {
    final result = await _apiManager.post(
      ApiEndpoint.reportAnswer,
      data: {
        "type": submitQuestionReportParam.submitQuestionReportParam?.type,
        "targetId":
            submitQuestionReportParam.submitQuestionReportParam?.targetId,
        "reason": submitQuestionReportParam.submitQuestionReportParam?.reason,
        "explanation":
            submitQuestionReportParam.submitQuestionReportParam?.explanation,
        "userId": submitQuestionReportParam.submitQuestionReportParam?.userId,
        "fileId": submitQuestionReportParam.submitQuestionReportParam?.fileId,
        "correctAnswerIndices": submitQuestionReportParam.indexes ?? [],
      },
    );

    return result.when(
      onSuccess:
          (res) => ApiResult.success(
            APIResponse.fromJson(
              res,
              (data) => SubmitQuestionReportModel.fromJson(res),
            ),
          ),
      onFailure: (message) => ApiResult.failure(message),
    );
  }
}
