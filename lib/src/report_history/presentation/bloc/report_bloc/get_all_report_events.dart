import 'package:flutter/cupertino.dart';

import '../../../data/models/get_all_reports.dart';

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

  ReportData report;
  BuildContext context;

  GetReasonEvent({
    required this.reportId,
    required this.context,
    required this.report,
  });
}
