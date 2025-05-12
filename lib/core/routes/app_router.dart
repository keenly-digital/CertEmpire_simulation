import 'package:certempiree/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../src/report_history/presentation/views/report_main_view.dart';
import '../../src/simulation/presentation/views/simulation_main_view.dart';
import 'app_route.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: 'report',
        name: AppRoute.simulation.name,
        builder: (context, state) =>ExamQuestionPage(),
      ), GoRoute(
        path: '/',
        name: AppRoute.report.name,
        builder: (context, state) =>  ReportMainView(),
      ),

    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Error: ${state.error.toString()}')),
    ),
  );
}
