import 'package:bloc/bloc.dart';
import 'package:certempiree/core/di/dependency_injection.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
import 'package:certempiree/core/utils/log_util.dart';
import 'package:certempiree/src/my_tasks/data/models/my_task_model.dart';
import 'package:certempiree/src/my_tasks/data/models/vote_task_param_model.dart';
import 'package:certempiree/src/my_tasks/domain/task/task_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/res/app_strings.dart';
import '../../widgets/explanation_report_task.dart';
import '../../widgets/question_report_task.dart';
import 'get_all_task_event.dart';
import 'get_all_task_state.dart';

class GetAllTaskBloc extends Bloc<GetAllTaskEvent, GetAllTaskState> {
  final TaskRepo _taskRepo = getIt<TaskRepo>();

  GetAllTaskBloc() : super(GetAllTaskState()) {
    on<GetAllTaskEvent>(_getAllTask);
  }

  Future<void> _getAllTask(
    GetAllTaskEvent event,
    Emitter<GetAllTaskState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final res = await _taskRepo.getAllTask(
      event.userId,
      event.pageNumber,
      event.pageSize,
    );
    res.when(
      onSuccess: (dataa) {
        emit(
          state.copyWith(
            isLoading: false,
            taskItem: dataa.data?.data?.data,
            totalItemLength: dataa.data?.data?.results,
          ),
        );
      },
      onFailure: (message) {
        emit(state.copyWith(isLoading: false, errorMessage: message));
      },
    );
  }

  void dialogueSelection(TaskItem? task, BuildContext context) {
    if (task?.reportType == "Question") {
      showDialog(

        barrierColor: Colors.transparent,
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: QuestionReportTask(taskItem: task),
          );
        },
      );
    } else if (task?.reportType == "Explanation" ||
        task?.reportType == "Answer") {
      showDialog(

        barrierColor: Colors.transparent,
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 24.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;
                double dialogWidth = width > 600 ? 500 : width * 0.75;

                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 0.90.sh,
                    maxWidth: dialogWidth,
                  ),
                  child: ExplanationReportTask(taskItem: task),
                );
              },
            ),
          );
        },
      );
    }
  }

  Future<void> voteTask(
    BuildContext context,
    VoteTaskParamModel voteTaskParamModel,
  ) async {
    CommonHelper.showLoader(context);
    final res = await _taskRepo.voteTask(voteTaskParamModel);
    res.when(
      onSuccess: (s) {
        CommonHelper.hideLoader(context);
        // CommonHelper.showToast(message: s.data?.message ?? "");
        Navigator.pop(context);
      },
      onFailure: (f) {
        CommonHelper.hideLoader(context);
        CommonHelper.showToast(message: f.toString());

        Navigator.pop(context);
      },
    );
    add(
      GetAllTaskEvent(userId: AppStrings.userId, pageNumber: 1, pageSize: 10),
    );
  }
}
