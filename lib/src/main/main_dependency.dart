import 'package:certempiree/core/di/dependency_injection.dart';
import 'package:certempiree/src/main/presentation/bloc/navigation_cubit.dart';

void mainDependency() {
  getIt.registerLazySingleton<NavigationCubit>(() {
    return NavigationCubit();
  });

}