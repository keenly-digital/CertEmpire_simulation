class GetAllTaskState {
  final bool isLoading;
  final String? errorMessage;

  const GetAllTaskState({
    this.isLoading = false,
    this.errorMessage,
  });

  GetAllTaskState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return GetAllTaskState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}