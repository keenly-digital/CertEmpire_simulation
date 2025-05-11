abstract class GetAllReportsEvent {
  String userId;
  int pageSize;
  int pageNumber;

  GetAllReportsEvent({
    required this.userId,
    required this.pageSize,
    required this.pageNumber,
  });
}
