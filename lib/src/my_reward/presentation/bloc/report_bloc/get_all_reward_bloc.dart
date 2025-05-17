import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:certempiree/core/shared/widgets/snakbar.dart';
import 'package:certempiree/core/utils/log_util.dart';
import 'package:flutter/material.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../data/models/get_all_reward_data_model.dart';
import '../../../domain/repos/report_repo.dart';
import '../../widgets/withdraw_request_dialogue.dart';
import 'get_all_reward_events.dart';
import 'get_all_reward_state.dart';

class MyRewardBloc extends Bloc<RewardInitEvent, RewardInitialState> {
  final RewardRepo _reportRepo = getIt<RewardRepo>();
  int cardIndex =-1;

  MyRewardBloc() : super(RewardInitialState()) {
    on<GetRewardsEvent>(_getRewards);
    on<WithDrawRewardEvent>(_withdrawReward);
  }

  Future<void> _getRewards(
    GetRewardsEvent event,
    Emitter<RewardInitialState> emit,
  ) async {
    emit(state.copyWith(loading: true, withDrawLoading: false));
    final res = await _reportRepo.getUserReward(event.userId);
    res.when(
      onSuccess: (data) {
        data.data?.data?.add(data.data?.data?[0] ?? RewardData());
        emit(state.copyWith(loading: false, rewardData: data.data?.data));
      },
      onFailure: (message) {
        LogUtil.debug("asdasdasd :$message");
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
    final res = await _reportRepo.withDrawReward(event.userId, event.fileId);
    res.when(
      onSuccess: (data) {
        emit(state.copyWith(withDrawLoading: false));

        showDialog(
          context: event.context,
          builder: (context) => WithdrawRequestDialog(),
          barrierDismissible: false,
        );
      },
      onFailure: (message) {
        LogUtil.debug(message);
        emit(state.copyWith(withDrawLoading: false, errorMessage: message));
      },
    );
  }
}
