class GetAllTaskEvent {
  String userId;
  int pageNumber;
  int pageSize;

  GetAllTaskEvent({
    required this.userId,
    required this.pageNumber,
    required this.pageSize,
  });
}
