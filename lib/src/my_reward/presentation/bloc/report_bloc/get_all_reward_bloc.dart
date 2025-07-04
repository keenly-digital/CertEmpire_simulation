import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:certempiree/core/shared/widgets/snakbar.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
import 'package:certempiree/core/utils/log_util.dart';
import 'package:certempiree/src/my_reward/presentation/widgets/success_dialogue.dart';
import 'package:flutter/material.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../domain/repos/report_repo.dart';
import '../../widgets/check_email_dialogue.dart';
import 'get_all_reward_events.dart';
import 'get_all_reward_state.dart';

class MyRewardBloc extends Bloc<RewardInitEvent, RewardInitialState> {
  final RewardRepo _reportRepo = getIt<RewardRepo>();
  int cardIndex = -1;

  MyRewardBloc() : super(RewardInitialState()) {
    on<GetRewardsEvent>(_getRewards);
    on<WithDrawRewardEvent>(_withdrawReward);
    on<GetCouponEvent>(_getCoupon);
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
        Navigator.pop(event.context);
        showDialog(
          context: event.context,
          builder: (context) => SuccessDialogue(),
          barrierDismissible: true,
          barrierColor: Colors.transparent,
        );
      },
      onFailure: (message) {
        CommonHelper.hideLoader(event.context);

        LogUtil.debug(message);
        emit(state.copyWith(withDrawLoading: false, errorMessage: message));
      },
    );
  }

  Future<void> _getCoupon(
    GetCouponEvent event,
    Emitter<RewardInitialState> emit,
  ) async {
    CommonHelper.showLoader(event.context);
    final res = await _reportRepo.getCoupon(event.userId, event.fileId);
    res.when(
      onSuccess: (data) async {
        CommonHelper.hideLoader(event.context);
        CommonHelper.showToast(message: data.message);
        Navigator.pop(event.context);
        await showDialog<String>(
          barrierColor: Colors.transparent,
          context: event.context,
          builder: (context) => const CheckEmailDialogue(),
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
