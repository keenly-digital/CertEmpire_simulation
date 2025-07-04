import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeftNavigationView extends StatelessWidget {
  const LeftNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final customerNavItems = [
      {'label': "Dashboard", 'route': '/main'},
      {'label': "Orders", 'route': '/Orders'},
      {'label': "Downloads", 'route': '/Downloads'},
      {'label': "My Tasks", 'route': '/MyTasks'},
      {'label': "Reports History", 'route': '/Report'},
      {'label': "My Rewards", 'route': '/MyRewards'},
      {'label': "My Submissions", 'route': '/MySubmissions'},
      {'label': "Addresses", 'route': '/Address'},
      {'label': "Account details", 'route': '/AccountDetails'},
      {'label': "Log out", 'route': '/Logout'},
    ];

    // Get the current location for highlight
    final currentLocation = GoRouterState.of(context).uri.toString();
    int selectedIndex = customerNavItems.indexWhere((item) {
      final route = item['route']!;
      // exact match OR path starts with this route (for nested)
      return currentLocation == route || currentLocation.startsWith('$route/');
    });

    // If nothing matches, fallback to first item
    if (selectedIndex == -1) selectedIndex = 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      // For logout you may want a special handler
                      final route = customerNavItems[index]['route']!;
                      context.go(route);
                      // Optionally, close drawer on mobile
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 22,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: isSelected ? 3 : 0,
                        horizontal: isSelected ? 6 : 0,
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
                                  width: 1.3,
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
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          letterSpacing: 0.14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
