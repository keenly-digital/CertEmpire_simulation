import 'package:bloc/bloc.dart';
import 'package:certempiree/core/di/dependency_injection.dart';
import 'package:certempiree/src/my_tasks/domain/task/task_repo.dart';

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
}
