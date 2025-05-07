import 'dart:io';

import '../../../../core/config/api/api_result.dart';

abstract class AuthRepo {
  Future<ApiResult<APIResponse<String?>>> getSimulationData(String req);
}
