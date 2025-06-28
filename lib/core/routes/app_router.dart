import 'package:certempiree/src/account_details/presentation/views/update_account_view.dart';
import 'package:certempiree/src/addresses/presentation/views/addresses_main_view.dart';
import 'package:certempiree/src/addresses/presentation/views/update_billing_address.dart';
import 'package:certempiree/src/addresses/presentation/views/update_shipping_address.dart';
import 'package:certempiree/src/main/presentation/views/main_page.dart';
import 'package:certempiree/src/my_reward/presentation/views/my_reward_main_view.dart';
import 'package:certempiree/src/my_tasks/presentation/views/my_task_main_veiw.dart';
import 'package:certempiree/src/order/presentation/views/order_detail_view.dart';
import 'package:certempiree/src/order/presentation/views/order_main_view.dart';
import 'package:certempiree/src/report_history/presentation/views/report_main_view.dart';
import 'package:certempiree/src/simulation/presentation/views/download_main_view.dart';
import 'package:certempiree/src/simulation/presentation/views/simulation_main_view.dart';
import 'package:certempiree/src/submittions/views/submittion_main_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_route.dart';

// Change this import to your actual dashboard/home widget for /main:
import 'package:certempiree/src/dashboard/presentation/views/dashboard_main_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/main',
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            path: '/main',
            name: AppRoute.main.name,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: UserMainView()),
          ),
          GoRoute(
            path: '/Orders',
            name: AppRoute.Orders.name,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: OrderMainView()),
          ),
          GoRoute(
            path: '/Orders/OrderDetail',
            name: AppRoute.OrderDetail.name,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: OrderDetailView()),
          ),
          GoRoute(
            path: '/Downloads',
            name: AppRoute.Downloads.name,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: DownloadMainView()),
          ),
          GoRoute(
            path: '/Downloads/Simulation',
            name: AppRoute.DownloadsSimulation.name,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: ExamQuestionPage()),
          ),
          GoRoute(
            path: '/Report',
            name: AppRoute.Report.name,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: ReportMainView()),
          ),
          GoRoute(
            path: '/MyRewards',
            name: AppRoute.MyRewards.name,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: MyRewardMainView()),
          ),
          GoRoute(
            path: '/MyTasks',
            name: AppRoute.MyTasks.name,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: MyTaskMainView()),
          ),
          GoRoute(
            path: '/MySubmissions',
            name: AppRoute.MySubmissions.name,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: SubmittionMainView()),
          ),
          GoRoute(
            path: '/Address',
            name: AppRoute.Address.name,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: AddressView()),
          ),
          GoRoute(
            path: '/Address/Billing',
            name: AppRoute.BillingAddress.name,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: UpdateBillingAddress()),
          ),
          GoRoute(
            path: '/Address/Shipping',
            name: AppRoute.ShippingAddress.name,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: UpdateShippingAddress()),
          ),
          GoRoute(
            path: '/AccountDetails',
            name: AppRoute.AccountDetails.name,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: UpdateAccount()),
          ),
        ],
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(child: Text('Error: ${state.error ?? "Unknown error"}')),
        ),
  );
}
