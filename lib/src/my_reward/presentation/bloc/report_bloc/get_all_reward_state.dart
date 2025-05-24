import 'package:equatable/equatable.dart';

import '../../../data/models/get_all_reward_data_model.dart';

class RewardInitialState extends Equatable {
  final List<RewardData>? rewardData;
  final bool? loading;
  final String? errorMessage;
  final bool? withDrawLoading;
  final int? itemLength;

  @override
  List<Object?> get props => [
    rewardData,
    loading,
    errorMessage,
    withDrawLoading,
    itemLength,
  ];

  const RewardInitialState({
    this.rewardData,
    this.itemLength=1,
    this.loading,
    this.errorMessage,
    this.withDrawLoading,
  });

  RewardInitialState copyWith({
    List<RewardData>? rewardData,
    bool? loading,
    String? errorMessage,
    int? itemLength,
    bool? withDrawLoading,
  }) {
    return RewardInitialState(
      itemLength: itemLength ?? this.itemLength,
      rewardData: rewardData ?? this.rewardData,
      withDrawLoading: withDrawLoading ?? this.withDrawLoading,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
