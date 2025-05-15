import '../../../../core/config/api/api_result.dart';
import '../../data/models/get_all_reward_data_model.dart';

abstract class RewardRepo {
  Future<ApiResult<APIResponse<GetAllRewardDataModel?>>> getUserReward(
    String reportId,
  );
}
