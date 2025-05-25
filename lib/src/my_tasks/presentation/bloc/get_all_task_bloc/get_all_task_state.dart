import '../../../data/models/my_task_model.dart';

class GetAllTaskState {
  final bool isLoading;
  final String? errorMessage;
  final List<TaskItem>? taskItem;
  final int? totalItemLength;

  const GetAllTaskState({
    this.isLoading = false,
    this.errorMessage,
    this.taskItem,
    this.totalItemLength
  });

  GetAllTaskState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<TaskItem>? taskItem,
    int? totalItemLength
  }) {
    return GetAllTaskState(
      totalItemLength: totalItemLength ?? this.totalItemLength,
      taskItem: taskItem ?? this.taskItem,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
