import 'package:bloc/bloc.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../domain/repos/report_repo.dart';
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
    emit((state as GetAllReportState).copyWith(reasonLoading: true));

    final res = await _reportRepo.getReportsReason(event.reportId);
    res.when(
      onSuccess: (data) {
        emit(
          GetAllReportState(
            reasonLoading: false,
            explanation: data.data?.data?.explanation ?? "",
          ),
        );
      },
      onFailure: (message) {
        emit(GetAllReportState(reasonLoading: false, explanation: message));
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
