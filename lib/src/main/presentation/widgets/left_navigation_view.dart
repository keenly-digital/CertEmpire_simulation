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
            const SizedBox(height: 20),
            Text(
              "${customerNavItems[state.index]['label']}",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.themeBlue),
            ),
            const SizedBox(height: 20),
            Container(
              width: 250, // adjust as needed
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...List.generate(customerNavItems.length, (index) {
                    final isSelected = state.index == index;
                    return Material(
                      color: isSelected ? AppColors.lightGreyBg : Colors.white,
                      child: InkWell(
                        onTap: () {
                          context.read<NavigationCubit>().selectTab(index, subTitle: 0);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                          child: Text(
                            customerNavItems[index]['label']!,
                            style: context.textTheme.titleSmall?.copyWith(color: isSelected ? Colors.black : AppColors.themeBlue),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
