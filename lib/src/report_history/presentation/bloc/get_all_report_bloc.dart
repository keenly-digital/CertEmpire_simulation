import 'package:bloc/bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../domain/repos/report_repo.dart';
import 'get_all_report_events.dart';
import 'get_all_report_state.dart';

class GetAllReportsBloc extends Bloc<GetAllReportsEvent, ReportInitialState> {
  final ReportRepo _reportRepo = getIt<ReportRepo>();

  GetAllReportsBloc() : super(GetAllReportState()) {
    on<GetAllReportsEvent>(_onFetchReports);
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
              reportData: res.data?.data,
              loading: false,
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
