import 'dart:convert';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_events.dart';
import 'package:certempiree/src/main/presentation/bloc/navigation_cubit.dart';
import 'package:certempiree/src/my_reward/presentation/bloc/report_bloc/get_all_reward_bloc.dart';
import 'package:certempiree/src/my_tasks/presentation/bloc/get_all_task_bloc/get_all_task_bloc.dart';
import 'package:certempiree/src/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:certempiree/src/report_history/presentation/bloc/report_bloc/get_all_report_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/download_page_bloc/download_page_bloc.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

/// Bootstraps app, loads user data ONCE before showing the rest of the app.
/// Can show splash/loading as needed.
class AppBootstrapper extends StatefulWidget {
  final Widget child;
  const AppBootstrapper({required this.child, super.key});

  @override
  State<AppBootstrapper> createState() => _AppBootstrapperState();
}

class _AppBootstrapperState extends State<AppBootstrapper> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    // Extract and set userId (from URL or keep your own logic here)
    final uri = Uri.base;
    final encodedData = uri.queryParameters['auth_token'];
    if (encodedData != null) {
      try {
        final decodedJson = utf8.decode(base64Url.decode(encodedData));
        final Map<String, dynamic> data = jsonDecode(decodedJson);
        AppStrings.id = data['id'] ?? '10860';
        AppStrings.userId = data['simulation_user_id'];
        AppStrings.authToken = encodedData;
        print(AppStrings.userId);
        print("Test");
      } catch (e) {
        debugPrint("Error decoding data: $e");
      }
    } else {
      debugPrint("No data received in query.");
    }

    // Always dispatch UserBloc event ONCE on app load
    context.read<UserBloc>().add(GetUserEvent(userId: AppStrings.id));

    setState(() => _initialized = true);
  }

  @override
  Widget build(BuildContext context) {
    // (Optional) Splash/loader until user is loaded, can use Bloc selector if you want!
    if (!_initialized) {
      return const Material(child: Center(child: CircularProgressIndicator()));
    }
    return widget.child;
  }
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
            BlocProvider(create: (context) => SearchQuestionCubit()),
            BlocProvider(create: (context) => GetAllTaskBloc()),
            BlocProvider(create: (context) => NavigationCubit()),
            BlocProvider(create: (context) => OrderBloc()),
            BlocProvider(create: (context) => UserBloc()),
            BlocProvider(create: (context) => DownloadPageBloc()),
          ],
          child: AppBootstrapper(
            child: MaterialApp.router(
              scaffoldMessengerKey: Snackbar.scaffoldMessengerKey,
              debugShowCheckedModeBanner: false,
              title: AppStrings.appName,
              theme: ThemeConfig.lightTheme(),
              darkTheme: ThemeConfig.lightTheme(),
              themeMode: ThemeMode.system,
              routerConfig: AppRouter.router,
              localizationsDelegates: [FlutterQuillLocalizations.delegate],
            ),
          ),
        );
      },
    );
  }
}
