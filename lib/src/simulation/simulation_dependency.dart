import 'package:certempiree/src/simulation/data/data_sources/simulation_remote_data_src.dart';
import 'package:certempiree/src/simulation/data/repo_Imp/simulation_repo_imp.dart';

import '../../core/config/api/api_manager.dart';
import '../../core/di/dependency_injection.dart';
import 'domain/repos/simulation_repo.dart';

void setupSimulationDependencies() {
  getIt.registerLazySingleton<SimulationDataSrc>(
    () => SimulationDataSrc(getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<SimulationRepo>(
    () => SimulationRepoImp(getIt<SimulationDataSrc>()),
  );
}
