import 'package:certempiree/core/config/api/api_result.dart';
import 'package:certempiree/src/report_history/data/data_sources/report_remote_data_src.dart';
import 'package:certempiree/src/report_history/data/models/get_all_reports.dart';

import '../../../report_history/data/models/view_reason_model.dart';
import '../../domain/repos/report_repo.dart';
import '../data_sources/reward_remote_data_src.dart';
import '../models/get_all_reward_data_model.dart';

class RewardRepoImp extends RewardRepo {
  final MyRewardDataSrc _remoteDataSrc;

  RewardRepoImp(this._remoteDataSrc);


  @override
  Future<ApiResult<APIResponse<GetAllRewardDataModel?>>> getUserReward(
    String reportId,
  ) async {
    return await _remoteDataSrc.getUserReward(reportId);
  }
}
