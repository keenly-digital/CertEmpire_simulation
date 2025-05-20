import 'package:certempiree/src/my_tasks/data/data_sources/my_task_data_src.dart';
import 'package:certempiree/src/my_tasks/data/repo_imp/task_repo_imp.dart';
import 'package:certempiree/src/my_tasks/domain/task/task_repo.dart';

import '../../core/config/api/api_manager.dart';
import '../../core/di/dependency_injection.dart';

void taskDependencies(){
  getIt.registerLazySingleton<MyTaskDataSrc>(
        () => MyTaskDataSrc(getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<TaskRepo>(
        () => TaskRepoImp(getIt<MyTaskDataSrc>()),
  );
}