import 'package:certempiree/src/report_history/data/models/get_all_reports.dart';
import 'package:equatable/equatable.dart';

abstract class ReportInitialState extends Equatable {}

class GetAllReportState extends ReportInitialState {
  final bool? loading;
  final String? errorMessage;
  final List<ReportData>? reportData;
  final bool? reasonLoading;
  final String? explanation;
  final int? results;

  GetAllReportState({
    this.loading,
    this.reportData,
    this.results,
    this.errorMessage,
    this.explanation,
    this.reasonLoading = false,
  });

  GetAllReportState copyWith({
    bool? loading,
    bool? reasonLoading,
    int? results,
    List<ReportData>? reportData,
    String? errorMessage,
    String? explanation,
  }) {
    return GetAllReportState(
      results: results ?? this.results,
      explanation: explanation ?? this.explanation,
      reasonLoading: reasonLoading ?? this.reasonLoading,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
      reportData: reportData ?? this.reportData,
    );
  }

  @override
  List<Object?> get props => [loading, errorMessage, reportData];
}
