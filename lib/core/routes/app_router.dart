import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../src/my_reward/presentation/views/my_reward_main_view.dart';
import '../../src/my_tasks/presentation/views/my_task_main_veiw.dart';
import '../../src/report_history/presentation/views/report_main_view.dart';
import '../../src/simulation/presentation/views/simulation_main_view.dart';
import 'app_route.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.simulation.name,
        builder: (context, state) => ExamQuestionPage(),
      ),
      GoRoute(
        path: '/report',
        name: AppRoute.report.name,
        builder: (context, state) => ReportMainView(),
      ),
      GoRoute(
        path: '/myRewardMainView',
        name: AppRoute.myRewardMainView.name,
        builder: (context, state) => MyRewardMainView(),
      ),  GoRoute(
        path: '/my_tasks',
        name: AppRoute.myTasks.name,
        builder: (context, state) => MyTaskMainView(),
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(child: Text('Error: ${state.error.toString()}')),
        ),
  );
}
