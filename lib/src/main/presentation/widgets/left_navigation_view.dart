import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Define your navigation items with their labels and route paths.
final List<Map<String, String>> customerNavItems = [
  {'label': "Dashboard", 'route': '/main'},
  {'label': "Orders", 'route': '/Orders'},
  {'label': "Downloads", 'route': '/Downloads'}, // <-- if you have this route!
  {'label': "My Tasks", 'route': '/MyTasks'},
  {'label': "Reports History", 'route': '/Report'},
  {'label': "My Rewards", 'route': '/MyRewards'},
  {'label': "My Submissions", 'route': '/MySubmissions'},
  {'label': "Addresses", 'route': '/Address'},
  {'label': "Account details", 'route': '/AccountDetails'},
  {'label': "Log out"},
];

class LeftNavigationView extends StatelessWidget {
  final bool isDrawer;
  final VoidCallback? onNavTap;
  const LeftNavigationView({super.key, this.isDrawer = false, this.onNavTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    // Detect the current path for highlight
    final currentLocation = GoRouterState.of(context).uri.toString();

    // Helper: find the current index from currentLocation for highlighting
    int selectedIndex = customerNavItems.indexWhere((item) {
      final route = item['route']!;
      // exact match OR path starts with this route (for nested)
      return currentLocation == route ||
          currentLocation.startsWith(route + '/');
    });

    // For Log out, you may want to handle differently (show dialog, etc.)
    void handleTap(int index) {
      final route = customerNavItems[index]['route']!;
      // Example: for Log out, show a dialog or run code if needed
      if (route == '/Logout') {
        // Your logout logic here, or navigate as normal if Logout is a route
        context.go(route);
      } else {
        context.go(route);
      }
      if (isDrawer || isMobile) {
        if (onNavTap != null) onNavTap!();
      }
    }

    final navList = ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding:
          isDrawer || isMobile
              ? const EdgeInsets.only(top: 40, left: 8, right: 8, bottom: 20)
              : EdgeInsets.zero,
      itemCount: customerNavItems.length,
      separatorBuilder:
          (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1, color: Colors.grey.shade100),
          ),
      itemBuilder: (context, index) {
        final isSelected = selectedIndex == index;
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(13),
            onTap: () => handleTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(
                vertical: isDrawer || isMobile ? 18 : 13,
                horizontal: isDrawer || isMobile ? 28 : 22,
              ),
              margin: EdgeInsets.symmetric(
                vertical: isSelected ? 4 : 0,
                horizontal: isSelected ? 8 : 0,
              ),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? AppColors.themeBlue.withOpacity(0.09)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(13),
                border:
                    isSelected
                        ? Border.all(
                          color: AppColors.themeBlue.withOpacity(0.21),
                          width: 1.2,
                        )
                        : null,
              ),
              child: Text(
                customerNavItems[index]['label']!,
                style: context.textTheme.titleMedium?.copyWith(
                  color:
                      isSelected
                          ? AppColors.themeBlue
                          : Colors.black.withOpacity(0.85),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  letterSpacing: 0.14,
                ),
              ),
            ),
          ),
        );
      },
    );

    if (isDrawer || isMobile) {
      return SafeArea(child: navList);
    }
    // Sidebar style (for desktop/tablet)
    return Container(
      width: 255,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200, width: 1.2),
      ),
      child: navList,
    );
  }
}
