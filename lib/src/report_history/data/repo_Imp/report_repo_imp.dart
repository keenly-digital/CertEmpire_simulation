import 'package:certempiree/core/config/api/api_result.dart';
import 'package:certempiree/src/report_history/data/data_sources/report_remote_data_src.dart';
import 'package:certempiree/src/report_history/data/models/get_all_reports.dart';

import '../../domain/repos/report_repo.dart';
import '../models/view_reason_model.dart';

class ReportRepoImp extends ReportRepo {
  final ReportRemoteDataSrc _remoteDataSrc;

  ReportRepoImp(this._remoteDataSrc);

  @override
  Future<ApiResult<APIResponse<GetAllReportsModel?>>> getAllReports(
    String userId,
    int pageNumber,
    int pageSize,
  ) async {
    return await _remoteDataSrc.getAllReports(userId, pageNumber, pageSize);
  }

  @override
  Future<ApiResult<APIResponse<ViewReportReason?>>> getReportsReason(
    String reportId,
  ) async {
    return await _remoteDataSrc.getReportReason(reportId);
  }
}
