import 'package:certempiree/src/report_history/data/models/get_all_reports.dart';
import 'package:equatable/equatable.dart';

abstract class ReportInitialState extends Equatable {}

class GetAllReportState extends ReportInitialState {
  bool? loading;
  String? errorMessage;
  List<ReportData>? reportData;

  GetAllReportState({this.loading, this.reportData, this.errorMessage});

  GetAllReportState copyWith({
    bool? loading,
    List<ReportData>? reportData,
    String? errorMessage,
  }) {
    return GetAllReportState(
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
      reportData: reportData ?? this.reportData,
    );
  }

  @override
  List<Object?> get props => [loading, errorMessage, reportData];
}
