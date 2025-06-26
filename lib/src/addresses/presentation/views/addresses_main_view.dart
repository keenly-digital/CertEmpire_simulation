import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/config/theme/font_manager.dart';
import 'package:certempiree/core/utils/spacer_utility.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main/presentation/bloc/navigation_cubit.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "The following addresses will be used on the checkout page by default.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // Billing Address
                BlocBuilder<UserBloc, UserInitialState>(
                  builder: (context, state) {
                    return Expanded(
                      child: _addressBox(
                        context: context,
                        title: "Billing address",
                        actionLabel: "Edit Billing address",
                        onActionTap: () {
                          context.read<NavigationCubit>().selectTab(
                            7,
                            subTitle: 1,
                          );
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.userData?.firstName ?? "First Name",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            Text(
                              state.userData?.billing?.postcode ?? "",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            Text(
                              state.userData?.billing?.country ?? "",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        color: AppColors.purple,
                      ),
                    );
                  },
                ),

                SpacerUtil.horizontalLarge(),
                // Shipping Address
                Expanded(
                  child: _addressBox(
                    context: context,
                    title: "Shipping address",
                    actionLabel: "Add Shipping address",
                    onActionTap: () {
                      context.read<NavigationCubit>().selectTab(7, subTitle: 2);
                    },
                    content: Column(
                      children: [
                        const Text(
                          "You have not set up this type of address yet.",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    color: AppColors.purple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _addressBox({
    required BuildContext context,
    required String title,
    required String actionLabel,
    required VoidCallback onActionTap,
    required Widget content,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),

      width: 355,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            color: AppColors.lightGreyBg,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: AppColors.lightPrimary,
                      fontWeight: FontManager.medium,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: onActionTap,
                      child: Text(
                        actionLabel,
                        style: TextStyle(
                          color: color,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }
}
