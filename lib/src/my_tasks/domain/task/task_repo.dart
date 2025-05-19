import 'package:certempiree/src/my_tasks/data/models/my_task_model.dart';

import '../../../../core/config/api/api_result.dart';

abstract class TaskRepo {
  Future<ApiResult<APIResponse<GetAllTaskModel?>>> getAllTask(String reportId);
}
