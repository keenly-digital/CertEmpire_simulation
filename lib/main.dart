import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/config/app_config.dart';
import 'core/config/theme/theme_config.dart';
import 'core/res/app_strings.dart';
import 'core/routes/app_router.dart';
import 'core/shared/widgets/snakbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        return MaterialApp.router(
          scaffoldMessengerKey: Snackbar.scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: ThemeConfig.lightTheme(),
          darkTheme: ThemeConfig.lightTheme(),
          themeMode: ThemeMode.system,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
