import 'package:certempiree/src/simulation/data/models/file_content_model.dart';
import 'package:certempiree/src/simulation/data/models/submit_report_model.dart';
import 'package:certempiree/src/simulation/data/models/submit_report_param.dart';
import 'package:certempiree/src/simulation/domain/repos/simulation_repo.dart';

import '../../../../core/config/api/api_result.dart';
import '../data_sources/simulation_remote_data_src.dart';
import '../models/report_ans_param_model.dart';


class SimulationRepoImp extends SimulationRepo {
  final SimulationDataSrc _simulationDataSrc;

  SimulationRepoImp(this._simulationDataSrc);

  @override
  Future<ApiResult<APIResponse<FileContent?>>> getSimulationData(
    String fileId,
  ) async {
    return await _simulationDataSrc.getSimulationData(fileId);
  }

  @override
  Future<ApiResult<APIResponse<SubmitQuestionReportModel?>>> reportQuestion(
    SubmitQuestionReportParam submitReportParam,
  ) async {
    return await _simulationDataSrc.reportQuestion(submitReportParam);
  }  @override
  Future<ApiResult<APIResponse<SubmitQuestionReportModel?>>> reportExplanation(
    SubmitQuestionReportParam submitReportParam,
  ) async {
    return await _simulationDataSrc.reportQuestion(submitReportParam);
  }

  @override
  Future<ApiResult<APIResponse<SubmitQuestionReportModel?>>> reportAnswer(
      ReportAnsParamsModel submitReportParam,
  ) async {
    return await _simulationDataSrc.reportAnswer(submitReportParam);
  }
}
