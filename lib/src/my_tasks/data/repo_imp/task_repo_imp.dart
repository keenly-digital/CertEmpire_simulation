import 'package:certempiree/core/config/api/api_result.dart';
import 'package:certempiree/src/my_reward/data/models/get_all_reward_data_model.dart';
import 'package:certempiree/src/my_tasks/data/data_sources/my_task_data_src.dart';
import 'package:certempiree/src/my_tasks/domain/task/task_repo.dart';

import '../models/my_task_model.dart';

class TaskRepoImp extends TaskRepo {
  final MyTaskDataSrc _myTaskDataSrc;

  TaskRepoImp(this._myTaskDataSrc);

  @override
  Future<ApiResult<APIResponse<GetAllTaskModel?>>> getAllTask(
    String reportId,
  ) async {
    return await _myTaskDataSrc.getMyTask(reportId);
  }
}
