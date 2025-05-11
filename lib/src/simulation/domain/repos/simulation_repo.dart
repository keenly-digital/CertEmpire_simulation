import 'package:certempiree/src/simulation/data/models/submit_report_model.dart';
import 'package:certempiree/src/simulation/data/models/submit_report_param.dart';

import '../../../../core/config/api/api_result.dart';
import '../../data/models/report_ans_param_model.dart';
import '../../data/models/simulation_model.dart';

abstract class SimulationRepo {
  Future<ApiResult<APIResponse<SimulationDataModel?>>> getSimulationData(
    String fileId,
  );

  Future<ApiResult<APIResponse<SubmitQuestionReportModel?>>> reportQuestion(
    SubmitQuestionReportParam submit,
  );
  Future<ApiResult<APIResponse<SubmitQuestionReportModel?>>> reportExplanation(
    SubmitQuestionReportParam submit,
  );

  Future<ApiResult<APIResponse<SubmitQuestionReportModel?>>> reportAnswer(
    ReportAnsParamsModel reportAnsParamsModel,
  );
}
