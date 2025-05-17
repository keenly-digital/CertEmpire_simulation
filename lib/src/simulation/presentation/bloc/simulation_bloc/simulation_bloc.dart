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
    on<ShowAnswerEvent>((_onChangeAnswer));
  }

  Future<void> _onFetchSimulationData(
    FetchSimulationDataEvent event,
    Emitter<SimulationInitState> emit,
  ) async {
    emit((state as SimulationState).copyWith(loading: true, success: false));
    final result = await _simulationRepo.getSimulationData(event.fieldId ?? "");
LogUtil.debug("${result.isSuccess}asdasd");
LogUtil.debug("${result.isSuccess}asdasd");
    await result.when(
      onSuccess: (res) async {
        LogUtil.debug("Simulation-onSuccess........... :${(res.data?.toJson())}");

        if (res.success && res.data != null) {
          emit(
            (state as SimulationState).copyWith(
              simulationData: res.data!,
              loading: false,
              success: true,
            ),
          );
          LogUtil.debug("${(state as SimulationState).simulationData}uwiueoiwueoiqweiou");
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

  Future<void> _onChangeAnswer(
    ShowAnswerEvent event,
    Emitter<SimulationInitState> emit,
  ) async {
    final currentState = state;

    if (currentState is SimulationState) {
      // final simulationData = currentState.simulationData;
      // if (simulationData == null || simulationData == null) return;
      //
      // // Create a new list with updated items
      // final updatedItems = simulationData.items!.map((item) {
      //   if (item.topic?.topicItems == null) return item;
      //
      //   // Create new topic with updated topic items
      //   final updatedTopicItems = item.topic!.topicItems!.map((topicItem) {
      //     if (topicItem.caseStudy?.questions == null) return topicItem;
      //
      //     // Create new case study with updated questions
      //     final updatedQuestions = topicItem.caseStudy!.questions!.asMap().entries.map((entry) {
      //       final index = entry.key;
      //       final question = entry.value;
      //
      //       // Only update the question at the specified index
      //       if (event.questionIndex == index) {
      //         return question.copyWith(
      //           showAnswer: !(question.showAnswer ?? false),
      //         );
      //       }
      //       return question;
      //     }).toList();
      //
      //     return topicItem.copyWith(
      //       caseStudy: topicItem.caseStudy?.copyWith(
      //         questions: updatedQuestions,
      //       ),
      //     );
      //   }).toList();
      //
      //   return item.copyWith(
      //     topic: item.topic?.copyWith(
      //       topicItems: updatedTopicItems,
      //     ),
      //   );
      // }).toList();
      //
      // emit(
      //   currentState.copyWith(
      //     simulationData: simulationData.copyWith(
      //       items: updatedItems,
      //     ),
      //   ),
      // );
    }
  }

  Future submitQuestionReport(
    SubmitQuestionReportParam submitReportParam,
    BuildContext context,
  ) async {
    CommonHelper.showLoader(context);

    final res = await _simulationRepo.reportQuestion(submitReportParam);
    return res.when(
      onSuccess: (data) async {
        CommonHelper.showLoader(context);
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

  Future submitExplanationReport(
    SubmitQuestionReportParam submitReportParam,
    BuildContext context,
  ) async {
    CommonHelper.showLoader(context);

    final res = await _simulationRepo.reportQuestion(submitReportParam);
    return res.when(
      onSuccess: (data) async {
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
