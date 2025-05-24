import '../../../../core/config/api/api_result.dart';
import '../../data/models/get_all_reward_data_model.dart';
import '../../data/models/withdraw_reward_model.dart';

abstract class RewardRepo {
  Future<ApiResult<APIResponse<GetAllRewardDataModel?>>> getUserReward(
      String userId,
      int pageSize,
      int pageNumber,  );

  Future<ApiResult<APIResponse<WithdrawRewardModel?>>> withDrawReward(
    String userId,
    String fileId,
  );
}
