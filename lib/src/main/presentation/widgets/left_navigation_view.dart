import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/navigation_cubit.dart';

class LeftNavigationView extends StatelessWidget {
  const LeftNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final customerNavItems = [
      {'label': "Dashboard"},
      {'label': "Orders"},
      {'label': "Downloads"},
      {'label': "My Tasks"},
      {'label': "Reports History"},
      {'label': "My Rewards"},
      {'label': "My Submissions"},
      {'label': "Addresses"},
      {'label': "Account details"},
      {'label': "Log out"},
    ];

    return BlocBuilder<NavigationCubit, NavigationCubitState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 14),
              child: Text(
                "${customerNavItems[state.index]['label']}",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.themeBlue,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
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
                  final isSelected = state.index == index;
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        context.read<NavigationCubit>().selectTab(
                          index,
                          subTitle: 0,
                        );
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
                                    color: AppColors.themeBlue.withOpacity(
                                      0.21,
                                    ),
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
                                isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
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
        );
      },
    );
  }
}
