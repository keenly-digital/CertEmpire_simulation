import 'package:certempiree/src/my_reward/data/data_sources/reward_remote_data_src.dart';
import 'package:certempiree/src/my_reward/domain/repos/report_repo.dart';

import '../../core/config/api/api_manager.dart';
import '../../core/di/dependency_injection.dart';
import 'data/repo_Imp/report_repo_imp.dart';

void rewardDependency() {
  getIt.registerLazySingleton<MyRewardDataSrc>(
    () => MyRewardDataSrc(getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<RewardRepo>(
    () => RewardRepoImp(getIt<MyRewardDataSrc>()),
  );
}
