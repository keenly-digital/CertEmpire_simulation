import 'package:certempiree/src/order/data/data_sources/order_remote_data_src.dart';
import 'package:certempiree/src/order/data/repo_Imp/order_repo_imp.dart';
import 'package:certempiree/src/order/domain/repos/order_repo.dart';

import '../../core/config/api/api_manager.dart';
import '../../core/di/dependency_injection.dart';

void orderDependency() {
  getIt.registerLazySingleton<OrderDataSrc>(
    () => OrderDataSrc(getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<OrderRepo>(
    () => OrderRepoImp(getIt<OrderDataSrc>()),
  );
}
