import '../../../data/models/my_task_model.dart';

class GetAllTaskState {
  final bool isLoading;
  final String? errorMessage;
  final List<TaskItem>? taskItem;

  const GetAllTaskState({
    this.isLoading = false,
    this.errorMessage,
    this.taskItem,
  });

  GetAllTaskState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<TaskItem>? taskItem,
  }) {
    return GetAllTaskState(
      taskItem: taskItem ?? this.taskItem,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
