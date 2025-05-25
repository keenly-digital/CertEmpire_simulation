import 'package:certempiree/core/config/api/api_result.dart';
import 'package:certempiree/src/my_tasks/data/data_sources/my_task_data_src.dart';
import 'package:certempiree/src/my_tasks/data/models/vote_task_param_model.dart';
import 'package:certempiree/src/my_tasks/domain/task/task_repo.dart';

import '../models/my_task_model.dart';
import '../models/vote_task_res_model.dart';

class TaskRepoImp extends TaskRepo {
  final MyTaskDataSrc _myTaskDataSrc;

  TaskRepoImp(this._myTaskDataSrc);

  @override
  Future<ApiResult<APIResponse<GetAllTaskModel?>>> getAllTask(
    String reportId,
      int pageNumber,
      int pageSize,
  ) async {
    return await _myTaskDataSrc.getMyTask(reportId,pageNumber,pageSize);
  }

  @override
  Future<ApiResult<APIResponse<VoteTaskResModel?>>> voteTask(
    VoteTaskParamModel voteTaskParamModel,
  ) async {
    return await _myTaskDataSrc.voteTask(voteTaskParamModel);
  }
}
