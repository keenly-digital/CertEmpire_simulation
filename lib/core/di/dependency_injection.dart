import 'package:get_it/get_it.dart';

import '../../src/main/main_dependency.dart';
import '../../src/my_reward/reward_dependency_injection.dart';
import '../../src/my_tasks/my_task_depenency.dart';
import '../../src/order/order_dependency_injection.dart';
import '../../src/report_history/report_history_dependencies.dart';
import '../../src/simulation/simulation_dependency.dart';
import '../config/api/api_manager.dart';
import '../config/api/dio_client_config.dart';
import '../config/db/shared_pref.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingletonAsync<SharedPref>(() async {
    final sharedPref = SharedPref();
    await sharedPref.initialize(); // Ensure SharedPreferences is initialized
    return sharedPref;
  });
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<ApiManager>(() => ApiManager(getIt<ApiClient>()));
  mainDependency();
  rewardDependency();
  taskDependencies();
  reportHistoryDependency();
  setupSimulationDependencies();
  orderDependency();

  await getIt.allReady();
}
