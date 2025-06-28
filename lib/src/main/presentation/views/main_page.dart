import 'package:certempiree/core/shared/widgets/header.dart';
import 'package:certempiree/src/logout/logout_main_view.dart';
import 'package:certempiree/src/main/presentation/widgets/left_navigation_view.dart';
import 'package:certempiree/src/my_reward/presentation/views/my_reward_main_view.dart';
import 'package:certempiree/src/my_tasks/presentation/views/my_task_main_veiw.dart';
import 'package:certempiree/src/order/presentation/views/order_main_view.dart';
import 'package:certempiree/src/report_history/presentation/views/report_main_view.dart';
import 'package:certempiree/src/simulation/presentation/views/download_main_view.dart';
import 'package:certempiree/src/simulation/presentation/views/simulation_main_view.dart';
import 'package:certempiree/src/submittions/views/submittion_main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/widgets/footer.dart';
import '../../../account_details/presentation/views/update_account_view.dart';
import '../../../addresses/presentation/views/addresses_main_view.dart';
import '../../../addresses/presentation/views/update_billing_address.dart';
import '../../../addresses/presentation/views/update_shipping_address.dart';
import '../../../dashboard/presentation/views/dashboard_main_view.dart';
import '../../../order/presentation/views/order_detail_view.dart';
import '../bloc/navigation_cubit.dart';
// No need to import LeftNavigationView directly anymore

import 'package:certempiree/core/shared/widgets/header.dart';
import 'package:certempiree/src/main/presentation/widgets/left_navigation_view.dart';
import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/footer.dart';

// No NavigationCubit or switch/case is needed with go_router ShellRoute!

class MainPage extends StatefulWidget {
  final Widget? child;
  const MainPage({super.key, this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[50],
      // Drawer only on mobile:
      drawer:
          isMobile
              ? Drawer(
                child: LeftNavigationView(
                  isDrawer: true,
                  onNavTap: () => Navigator.of(context).pop(),
                ),
              )
              : null,
      body: Column(
        children: [
          // Responsive header, shows hamburger only on mobile
          Header(
            onHamburgerTap:
                isMobile ? () => _scaffoldKey.currentState?.openDrawer() : null,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Sidebar: only show on desktop/tablet!
                if (!isMobile)
                  Container(
                    width: 230,
                    margin: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                      bottom: 16,
                    ),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        child: LeftNavigationView(),
                      ),
                    ),
                  ),
                // Main content: This part scrolls and displays the active route
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Render the child page from go_router ShellRoute
                        if (widget.child != null)
                          widget.child!
                        else
                          const Center(
                            child: Text("No content for this route"),
                          ),
                        // Add space before the footer for breathing room
                        const SizedBox(height: 100),
                        const Footer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper for consistent content padding
Widget content(Widget widget, {double top = 24.0, double horizontal = 24.0}) {
  return Padding(
    padding: EdgeInsets.only(top: top, left: horizontal, right: horizontal),
    child: widget,
  );
}
