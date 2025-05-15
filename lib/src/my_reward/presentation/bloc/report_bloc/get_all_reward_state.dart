import 'package:equatable/equatable.dart';

import '../../../data/models/get_all_reward_data_model.dart';

class RewardInitialState extends Equatable {
  final List<RewardData>? rewardData;
  final bool? loading;
  final String? errorMessage;

  @override
  List<Object?> get props => [rewardData, loading, errorMessage];

  const RewardInitialState({this.rewardData, this.loading, this.errorMessage});

  RewardInitialState copyWith({
    List<RewardData>? rewardData,
    bool? loading,
    String? errorMessage,
  }) {
    return RewardInitialState(
      rewardData: rewardData ?? this.rewardData,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
