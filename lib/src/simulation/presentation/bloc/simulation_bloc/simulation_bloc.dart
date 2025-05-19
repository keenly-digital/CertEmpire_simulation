import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:certempiree/core/shared/widgets/snakbar.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
import 'package:certempiree/src/simulation/data/models/submit_report_param.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_event.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_state.dart';
import 'package:flutter/material.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/utils/log_util.dart';
import '../../../domain/repos/simulation_repo.dart';
import '../../widgets/thank_you_dialogue.dart';

class SimulationBloc extends Bloc<SimulationEvent, SimulationInitState> {
  final SimulationRepo _simulationRepo = getIt<SimulationRepo>();

  SimulationBloc() : super(SimulationState()) {
    on<FetchSimulationDataEvent>((_onFetchSimulationData));
  }

  Future<void> _onFetchSimulationData(
    FetchSimulationDataEvent event,
    Emitter<SimulationInitState> emit,
  ) async {
    emit((state as SimulationState).copyWith(loading: true, success: false));
    final result = await _simulationRepo.getSimulationData(event.fieldId ?? "");
    await result.when(
      onSuccess: (res) async {
        LogUtil.debug(
          "Simulation-onSuccess........... :${(res.data?.toJson())}",
        );

        if (res.success && res.data != null) {
          emit(
            (state as SimulationState).copyWith(
              simulationData: res.data!,
              loading: false,
              success: true,
            ),
          );
        } else {
          emit(
            (state as SimulationState).copyWith(loading: false, success: false),
          );
        }
      },
      onFailure: (message) async {
        LogUtil.debug("Simulation-onFailure :$message");
        emit(
          (state as SimulationState).copyWith(loading: false, success: false),
        );
      },
    );
  }

  Future submitQuestionReport(
    SubmitQuestionReportParam submitReportParam,
    BuildContext context,
  ) async {
    CommonHelper.showLoader(context);

    final res = await _simulationRepo.reportQuestion(submitReportParam);
    return res.when(
      onSuccess: (data) async {
        CommonHelper.hideLoader(context);
        showDialog(
          context: context,

          builder: (context) => ThankYouDialogue(),
          barrierDismissible: false,
        );

        Snackbar.show(data.message);
      },
      onFailure: (message) {
        Snackbar.show(message);
        CommonHelper.hideLoader(context);
        return message;
      },
    );
  }

  Future submitExplanationReport(
    SubmitQuestionReportParam submitReportParam,
    BuildContext context,
  ) async {
    CommonHelper.showLoader(context);

    final res = await _simulationRepo.reportQuestion(submitReportParam);
    return res.when(
      onSuccess: (data)  {
        Navigator.pop(context);

        showDialog(
          context: context,
          builder: (context) => ThankYouDialogue(),
          barrierDismissible: false,
        );

        Snackbar.show(data.message);
      },
      onFailure: (message) {
        Snackbar.show(message);
        CommonHelper.hideLoader(context);
        return message;
      },
    );
  }
}
