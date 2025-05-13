abstract class ReportInitEvent {}

class GetAllReportsEvent extends ReportInitEvent {
  String userId;
  int pageSize;
  int pageNumber;

  GetAllReportsEvent({
    required this.userId,
    required this.pageSize,
    required this.pageNumber,
  });
}

class GetReasonEvent extends ReportInitEvent {
  String reportId;

  GetReasonEvent({required this.reportId});
}
