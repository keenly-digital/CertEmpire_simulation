import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:certempiree/core/shared/widgets/snakbar.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
import 'package:certempiree/core/utils/log_util.dart';
import 'package:certempiree/src/my_reward/presentation/widgets/success_dialogue.dart';
import 'package:flutter/material.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../domain/repos/report_repo.dart';
import 'get_all_reward_events.dart';
import 'get_all_reward_state.dart';

class MyRewardBloc extends Bloc<RewardInitEvent, RewardInitialState> {
  final RewardRepo _reportRepo = getIt<RewardRepo>();
  int cardIndex = -1;

  MyRewardBloc() : super(RewardInitialState()) {
    on<GetRewardsEvent>(_getRewards);
    on<WithDrawRewardEvent>(_withdrawReward);
  }

  Future<void> _getRewards(
    GetRewardsEvent event,
    Emitter<RewardInitialState> emit,
  ) async {
    emit(state.copyWith(loading: true, withDrawLoading: false));
    final res = await _reportRepo.getUserReward(
      event.userId,
      event.pageSize,
      event.pageNumber,
    );
    res.when(
      onSuccess: (data) {
        // List<RewardData> currentList = state.rewardData ?? [];
        // List<RewardData> newList = data.data?.data ?? [];
        // if (newList.isEmpty && event.pageNumber > 1) {
        //   CommonHelper.showToast(message: "No More Reward");
        // }
        // final updatedList = [...currentList, ...newList];
        emit(
          state.copyWith(
            loading: false,
            rewardData: data.data?.data ?? [],
            itemLength: data.data?.results,
          ),
        );
      },
      onFailure: (message) {
        Snackbar.show(message);
        emit(state.copyWith(loading: false, errorMessage: message));
      },
    );
  }

  Future<void> _withdrawReward(
    WithDrawRewardEvent event,
    Emitter<RewardInitialState> emit,
  ) async {
    emit(state.copyWith(withDrawLoading: true));
    CommonHelper.showLoader(event.context);
    final res = await _reportRepo.withDrawReward(event.userId, event.fileId);
    res.when(
      onSuccess: (data) {
        CommonHelper.hideLoader(event.context);

        emit(state.copyWith(withDrawLoading: false));

        showDialog(
          context: event.context,
          builder: (context) => SuccessDialogue(),
          barrierDismissible: true,
        );
      },
      onFailure: (message) {
        CommonHelper.hideLoader(event.context);

        LogUtil.debug(message);
        emit(state.copyWith(withDrawLoading: false, errorMessage: message));
      },
    );
  }
}
