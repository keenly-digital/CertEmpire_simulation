import 'package:flutter/material.dart';
import '../widgets/left_navigation_view.dart';
import '../../../../core/shared/widgets/header.dart';
import '../../../../core/shared/widgets/footer.dart';

class MainPage extends StatefulWidget {
  final Widget? child;
  const MainPage({super.key, this.child});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  @override
  Widget build(BuildContext context) {
    // Get route for padding logic (for exam page special top padding)
    final String currentLocation = Uri.base.path; // works in web and go_router

    // Responsive padding logic
    double horizontalPad = isMobile(context) ? 8.0 : 24.0;
    double topPad = isMobile(context) ? 12.0 : 24.0;

    // Use smaller top padding for a specific route if needed
    if (currentLocation == '/Downloads/Simulation') {
      topPad = isMobile(context) ? 2.0 : 1.0;
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[50],
      drawer:
          isMobile(context)
              ? Drawer(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: LeftNavigationView(),
                  ),
                ),
              )
              : null,
      body: Column(
        children: [
          // Header with hamburger for mobile
          header(onMenu: () => _scaffoldKey.currentState?.openDrawer()),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Desktop/tablet sidebar
                if (!isMobile(context))
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
                // Main content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (widget.child != null)
                          content(
                            widget.child!,
                            top: topPad,
                            horizontal: horizontalPad,
                          )
                        else
                          const Center(
                            child: Text("No content for this route"),
                          ),
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

  // Responsive content padding, keep as before!
  Widget content(Widget widget, {double top = 24.0, double horizontal = 24.0}) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: horizontal, right: horizontal),
      child: widget,
    );
  }
}
