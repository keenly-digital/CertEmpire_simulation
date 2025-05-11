import 'package:get_it/get_it.dart';
import '../../src/simulation/simulation_dependency.dart';
import '../config/api/api_manager.dart';
import '../config/api/dio_client_config.dart';
import '../config/db/shared_pref.dart';
import '../utils/file_manager.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingletonAsync<SharedPref>(() async {
    final sharedPref = SharedPref();
    await sharedPref.initialize(); // Ensure SharedPreferences is initialized
    return sharedPref;
  });

  // Register ApiClient as a singleton
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  // Register ApiManager as a singleton
  getIt.registerLazySingleton<ApiManager>(() => ApiManager(getIt<ApiClient>()));

  setupSimulationDependencies();

  await getIt.allReady();
}


