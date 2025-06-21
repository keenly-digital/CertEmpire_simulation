import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/navigation_cubit.dart';
import 'nav_item_view.dart';

class LeftNavigationView extends StatelessWidget {
  const LeftNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final customerNavItems = [
      {'label': "Dashboard"},
      {'label': "Orders"},
      {'label': "Downloads"},
      {'label': "My Tasks"},
      {'label': "Report History"},
      {'label': "My Reward"},
      {'label': "Addresses"},
      {'label': "My Submissions"},
      {'label': "Account Details"},
      {'label': "Payment Methods"},
      {'label': "Logout"},
    ];

    return BlocBuilder<NavigationCubit, NavigationCubitState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${customerNavItems[state.index]['label']}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: customerNavItems.length,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  final item = customerNavItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.unselected),
                      ),
                      child: NavItemView(
                        label: item['label'].toString(),
                        isSelected: state.index == index,
                        onTap: () {
                          context.read<NavigationCubit>().selectTab(index);
                        },
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
