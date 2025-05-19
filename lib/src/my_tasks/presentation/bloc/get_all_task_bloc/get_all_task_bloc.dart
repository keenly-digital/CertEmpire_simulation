import 'package:bloc/bloc.dart';
import 'package:certempiree/src/my_tasks/domain/task/task_repo.dart';

import 'get_all_task_event.dart';
import 'get_all_task_state.dart';

class GetAllTaskBloc extends Bloc<GetAllTaskEvent, GetAllTaskState> {
  final TaskRepo _taskRepo;

  GetAllTaskBloc(this._taskRepo) : super(GetAllTaskState()) {
    on<GetAllTaskEvent>(_getAllTask);
  }

  Future<void> _getAllTask(
    GetAllTaskEvent event,
    Emitter<GetAllTaskState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final res = await _taskRepo.getAllTask(event.userId);
    res.when(
      onSuccess: (data) {
        emit(state.copyWith(isLoading: false));
      },
      onFailure: (message) {
        emit(state.copyWith(isLoading: false, errorMessage: message));
      },
    );
  }
}
