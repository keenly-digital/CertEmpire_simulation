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
      {'label': "My Submissions"},
      {'label': "Addresses"},
      {'label': "Account Details"},
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: customerNavItems.length,
              itemBuilder: (context, index) {
                final item = customerNavItems[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: NavItemView(
                    label: item['label'].toString(),
                    isSelected: state.index == index,
                    onTap: () {
                      context.read<NavigationCubit>().selectTab(
                        index,
                        subTitle: 0,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
