import 'package:certempiree/core/config/api/api_result.dart';

import '../../domain/repos/report_repo.dart';
import '../data_sources/reward_remote_data_src.dart';
import '../models/get_all_reward_data_model.dart';
import '../models/withdraw_reward_model.dart';

class RewardRepoImp extends RewardRepo {
  final MyRewardDataSrc _remoteDataSrc;

  RewardRepoImp(this._remoteDataSrc);

  @override
  Future<ApiResult<APIResponse<GetAllRewardDataModel?>>> getUserReward(
      String userId,
      int pageSize,
      int pageNumber,
  ) async {
    return await _remoteDataSrc.getUserReward(userId,pageSize,pageNumber);
  }

  @override
  Future<ApiResult<APIResponse<WithdrawRewardModel?>>> withDrawReward(
    String userId,
    String fileId,
  ) async {
    return await _remoteDataSrc.withDrawReward(userId, fileId);
  }
}
