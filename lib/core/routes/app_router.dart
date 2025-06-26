import 'package:certempiree/src/addresses/presentation/views/update_billing_address.dart';
import 'package:certempiree/src/main/presentation/views/main_page.dart';
import 'package:certempiree/src/my_reward/presentation/views/my_reward_main_view.dart';
import 'package:certempiree/src/my_tasks/presentation/views/my_task_main_veiw.dart';
import 'package:certempiree/src/report_history/presentation/views/report_main_view.dart';
import 'package:certempiree/src/simulation/presentation/views/simulation_main_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_route.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/main',
    routes: [
      GoRoute(
        path: '/main',
        name: AppRoute.main.name,
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: '/Simulation',
        name: AppRoute.simulation.name,
        builder: (context, state) => const ExamQuestionPage(),
      ),
      GoRoute(
        path: '/Report',
        name: AppRoute.report.name,
        builder: (context, state) => ReportMainView(),
      ),
      GoRoute(
        path: '/MyRewards',
        name: AppRoute.myRewardMainView.name,
        builder: (context, state) => const MyRewardMainView(),
      ),
      GoRoute(
        path: '/MyTasks',
        name: AppRoute.myTasks.name,
        builder: (context, state) => const MyTaskMainView(),
      ),
      GoRoute(
        path: '/UpdateBillingAddress',
        name: AppRoute.updateBillingAddress.name,
        builder: (context, state) => const UpdateBillingAddress(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Error: ${state.error.toString()}')),
    ),
  );
}
