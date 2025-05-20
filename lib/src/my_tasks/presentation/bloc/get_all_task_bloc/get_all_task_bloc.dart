import 'package:bloc/bloc.dart';
import 'package:certempiree/core/di/dependency_injection.dart';
import 'package:certempiree/src/my_tasks/data/models/my_task_model.dart';
import 'package:certempiree/src/my_tasks/domain/task/task_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/theme/app_colors.dart';
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
    final res = await _taskRepo.getAllTask(event.userId);
    res.when(
      onSuccess: (dataa) {
        emit(state.copyWith(isLoading: false, taskItem: dataa.data?.data));
      },
      onFailure: (message) {
        emit(state.copyWith(isLoading: false, errorMessage: message));
      },
    );
  }

  void dialogueSelection(TaskItem? task, BuildContext context) {
    if (task?.reportType == "Question") {
      showDialog(
        context: context,
        barrierDismissible: false,
        // set true if you want to dismiss by tapping outside
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;
                double dialogWidth = width > 600 ? 500 : width * 0.9;
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 0.90.sh,
                    maxWidth: dialogWidth,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.purple, width: 2),
                    ),
                    child: QuestionReportTask(taskItem: task),
                  ),
                );
              },
            ),
          );
        },
      );
    }
  }
}
