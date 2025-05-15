import 'package:bloc/bloc.dart';
import 'package:certempiree/core/utils/log_util.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../domain/repos/report_repo.dart';
import 'get_all_reward_events.dart';
import 'get_all_reward_state.dart';

class MyRewardBloc extends Bloc<RewardInitEvent, RewardInitialState> {
  final RewardRepo _reportRepo = getIt<RewardRepo>();

  MyRewardBloc() : super(RewardInitialState()) {
    on<GetRewardsEvent>(_getRewards);
  }

  Future<void> _getRewards(
    GetRewardsEvent event,
    Emitter<RewardInitialState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    final res = await _reportRepo.getUserReward(event.userId);
    res.when(
      onSuccess: (data) {
        emit(state.copyWith(loading: false, rewardData: data.data?.data));
        LogUtil.debug("ssdasda${data.data?.data?[0].toJson()}");
      },
      onFailure: (message) {
        emit(state.copyWith(loading: false, errorMessage: message));
      },
    );
  }
}
