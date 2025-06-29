import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_route.dart';

extension AppNavigation on BuildContext {
  void goToSimulation() => goNamed(AppRoute.DownloadsSimulation.name);

  void goToReport() => goNamed(AppRoute.Report.name);
}
