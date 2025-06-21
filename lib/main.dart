import 'dart:convert';

import 'package:certempiree/src/main/presentation/bloc/navigation_cubit.dart';
import 'package:certempiree/src/my_reward/presentation/bloc/report_bloc/get_all_reward_bloc.dart';
import 'package:certempiree/src/my_tasks/presentation/bloc/get_all_task_bloc/get_all_task_bloc.dart';
import 'package:certempiree/src/report_history/presentation/bloc/report_bloc/get_all_report_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_bloc.dart';
import 'package:certempiree/src/simulation/presentation/cubit/report_ans_cubit.dart';
import 'package:certempiree/src/simulation/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/config/app_config.dart';
import 'core/config/theme/theme_config.dart';
import 'core/di/dependency_injection.dart';
import 'core/res/app_strings.dart';
import 'core/routes/app_router.dart';
import 'core/shared/widgets/snakbar.dart';

String? screenName, userId, fileId;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _handleIncomingLink();
  }

  void _handleIncomingLink() {
    final uri = Uri.base;
    final encodedData = uri.queryParameters['data'];
    if (encodedData != null) {
      try {
        final decodedJson = utf8.decode(base64Url.decode(encodedData));
        final Map<String, dynamic> data = jsonDecode(decodedJson);
        AppStrings.fileId = data['fileId'];
        fileId = data['fileId'];
        AppStrings.userId = data['userId'];
        userId = data['userId'];
        setState(() {});
      } catch (e) {
        debugPrint("Error decoding data: $e");
      }
    } else {
      debugPrint("No data received in query.");
    }
  }

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
            BlocProvider(create: (context) => SearchQuestionCubit()),
            BlocProvider(create: (context) => GetAllTaskBloc()),
            BlocProvider(create: (context) => NavigationCubit()),
          ],
          child: MaterialApp.router(
            scaffoldMessengerKey: Snackbar.scaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            theme: ThemeConfig.lightTheme(),
            darkTheme: ThemeConfig.lightTheme(),
            themeMode: ThemeMode.system,
            routerConfig: AppRouter.router,
            localizationsDelegates: [
              FlutterQuillLocalizations.delegate,
            ],
          ),
        );
      },
    );
  }
}
