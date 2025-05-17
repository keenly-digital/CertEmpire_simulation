import 'package:bloc/bloc.dart';
import 'package:certempiree/core/di/dependency_injection.dart';
import 'package:certempiree/core/shared/widgets/snakbar.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
import 'package:certempiree/src/simulation/data/models/report_ans_param_model.dart';
import 'package:certempiree/src/simulation/data/models/file_content_model.dart';
import 'package:certempiree/src/simulation/domain/repos/simulation_repo.dart';
import 'package:certempiree/src/simulation/presentation/cubit/report_ans_state.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/utils/log_util.dart';
import '../../data/models/question_model.dart';

class ReportAnsCubit extends Cubit<ReportAnswerState> {
  final SimulationRepo _simulationRepo = getIt<SimulationRepo>();

  ReportAnsCubit() : super(ReportAnswerState());

  void reportAnswerAsIncorrect(Question? question) {
    emit(state.copyWith(question: question));
  }

  void toggleOptionSelection(int index) {
    final current = List<int>.from(state.selectedOptionIndices);
    if (current.contains(index)) {
      current.remove(index);
    } else {
      current.add(index);
    }
    emit(state.copyWith(selectedOptionIndices: current));
  }

  Future<void> submitReport(
    ReportAnsParamsModel reportAns,
    BuildContext context,
  ) async {
    CommonHelper.showLoader(context);
    final res = await _simulationRepo.reportAnswer(reportAns);
    await res.when(
      onSuccess: (res) async {
        LogUtil.debug("SubmitReport-onSuccess :${(res.data?.toJson())}");
        if (res.success) {
          Snackbar.show(res.message);
        }
      },

      onFailure: (message) async {
        LogUtil.debug("Submit Report-onFailure :$message");
      },
    );
    Navigator.pop(context);
  }
}
