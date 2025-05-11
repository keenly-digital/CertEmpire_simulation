import 'package:certempiree/src/report_history/data/models/get_all_reports.dart';

import '../../../../core/config/api/api_result.dart';

abstract class ReportRepo {
  Future<ApiResult<APIResponse<GetAllReportsModel?>>> getAllReports(
    String userId,
    int pageNumber,
    int pageSize,
  );
}
