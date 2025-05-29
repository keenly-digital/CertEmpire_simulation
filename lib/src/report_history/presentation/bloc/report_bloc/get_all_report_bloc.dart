import 'package:bloc/bloc.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
import 'package:flutter/material.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../domain/repos/report_repo.dart';
import '../../widgets/view_reason_dialogue.dart';
import 'get_all_report_events.dart';
import 'get_all_report_state.dart';

class GetAllReportsBloc extends Bloc<ReportInitEvent, ReportInitialState> {
  final ReportRepo _reportRepo = getIt<ReportRepo>();

  GetAllReportsBloc() : super(GetAllReportState()) {
    on<GetAllReportsEvent>(_onFetchReports);
    on<GetReasonEvent>(_getReason);
  }

  Future<void> _getReason(
    GetReasonEvent event,
    Emitter<ReportInitialState> emit,
  ) async {
    CommonHelper.showLoader(event.context);
    emit(
      (state as GetAllReportState).copyWith(
        reasonLoading: true,
        explanation: "",
      ),
    );
    final res = await _reportRepo.getReportsReason(event.reportId);
    CommonHelper.hideLoader(event.context);
    res.when(
      onSuccess: (data) {
        final explanationText = data.data?.data?.explanation ?? "";
        emit(
          GetAllReportState(
            reasonLoading: false,
            explanation: explanationText,
            reportData: (state as GetAllReportState).reportData,
            results: (state as GetAllReportState).results,
          ),
        );

        showDialog(
          context: event.context,
          barrierColor: Colors.transparent,
          builder:
              (_) => ViewReasonDialog(
                reportData: event.report,
                explantion: explanationText, // Don't use state here
              ),
        );
      },
      onFailure: (message) {
        emit(
          GetAllReportState(
            reasonLoading: false,
            explanation: message,
            reportData: (state as GetAllReportState).reportData,
            results: (state as GetAllReportState).results,
          ),
        );
      },
    );
  }

  Future<void> _onFetchReports(
    GetAllReportsEvent event,
    Emitter<ReportInitialState> emit,
  ) async {
    emit((state as GetAllReportState).copyWith(loading: true));

    final result = await _reportRepo.getAllReports(
      event.userId,
      event.pageNumber,
      event.pageSize,
    );
    await result.when(
      onSuccess: (res) async {
        if (res.success && res.data != null) {
          emit(
            (state as GetAllReportState).copyWith(
              reportData: res.data?.data?.data,
              loading: false,
              results: res.data?.data?.results ?? 0,
            ),
          );
        } else {
          emit(
            (state as GetAllReportState).copyWith(
              loading: false,
              reportData: [],
            ),
          );
        }
      },
      onFailure: (message) async {
        emit((state as GetAllReportState).copyWith(loading: false));
      },
    );
  }
}
