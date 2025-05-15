import 'package:certempiree/src/my_reward/presentation/bloc/report_bloc/get_all_reward_bloc.dart';
import 'package:certempiree/src/report_history/presentation/bloc/report_bloc/get_all_report_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_bloc.dart';
import 'package:certempiree/src/simulation/presentation/cubit/report_ans_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/config/app_config.dart';
import 'core/config/theme/theme_config.dart';
import 'core/di/dependency_injection.dart';
import 'core/res/app_strings.dart';
import 'core/routes/app_router.dart';
import 'core/shared/widgets/snakbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppConfig().initialize(context);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => SimulationBloc()),
            BlocProvider(create: (context) => ReportAnsCubit()),
            BlocProvider(create: (context) => GetAllReportsBloc()),
            BlocProvider(create: (context) => MyRewardBloc()),
          ],
          child: MaterialApp.router(
            scaffoldMessengerKey: Snackbar.scaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            theme: ThemeConfig.lightTheme(),
            darkTheme: ThemeConfig.lightTheme(),
            themeMode: ThemeMode.system,
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
