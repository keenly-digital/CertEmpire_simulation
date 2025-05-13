import 'package:bloc/bloc.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../domain/repos/report_repo.dart';
import 'get_all_report_events.dart';
import 'get_all_report_state.dart';

class GetAllReportsBloc extends Bloc<ReportInitEvent, ReportInitialState> {
  final ReportRepo _reportRepo = getIt<ReportRepo>();

  GetAllReportsBloc() : super(GetAllReportState()) {
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


}
