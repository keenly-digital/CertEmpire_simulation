import 'package:certempiree/src/report_history/data/data_sources/report_remote_data_src.dart';
import 'package:certempiree/src/report_history/data/repo_Imp/report_repo_imp.dart';
import 'package:certempiree/src/report_history/domain/repos/report_repo.dart';

import '../../core/config/api/api_manager.dart';
import '../../core/di/dependency_injection.dart';

void reportHistoryDependency() {
  getIt.registerLazySingleton<ReportRemoteDataSrc>(
    () => ReportRemoteDataSrc(getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<ReportRepo>(
    () => ReportRepoImp(getIt<ReportRemoteDataSrc>()),
  );
}
