import 'package:certempiree/src/my_tasks/data/models/my_task_model.dart';

import '../../../../core/config/api/api_result.dart';
import '../../data/models/vote_task_param_model.dart';
import '../../data/models/vote_task_res_model.dart';

abstract class TaskRepo {
  Future<ApiResult<APIResponse<GetAllTaskModel?>>> getAllTask(String reportId);
  Future<ApiResult<APIResponse<VoteTaskResModel?>>> voteTask(VoteTaskParamModel voteTaskParamModel);
}
