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
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 820;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 40 : 10,
          vertical: isWide ? 38 : 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Card
            Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              color: const Color(0xFFF2F4FB),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width < 500 ? 12 : 22,
                  vertical: width < 500 ? 12 : 18,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.themeBlue,
                      size: 26,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        "The following addresses will be used on the checkout page by default.",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.themeBlue,
                          fontWeight: FontManager.semiBold,
                          fontSize: 16.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Responsive billing + shipping
            isWide
                ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _BillingCard()),
                    SpacerUtil.horizontalLarge(),
                    Expanded(child: _ShippingCard()),
                  ],
                )
                : Column(
                  children: [
                    _BillingCard(),
                    const SizedBox(height: 30),
                    _ShippingCard(),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}

class _BillingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserInitialState>(
      builder: (context, state) {
        final billing = state.userData?.billing;
        return _ModernAddressCard(
          title: "Billing Address",
          actionLabel: "Edit Billing address",
          onActionTap: () {
            context.read<NavigationCubit>().selectTab(7, subTitle: 1);
          },
          fields: [
            billing?.firstName ?? "First Name",
            billing?.company ?? "",
            billing?.address1 ?? "",
            billing?.address2 ?? "",
            billing?.city ?? "",
            billing?.postcode ?? "",
            billing?.country ?? "",
          ],
        );
      },
    );
  }
}

class _ShippingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserInitialState>(
      builder: (context, state) {
        final shipping = state.userData?.shipping;
        final isEmpty =
            shipping == null ||
            (shipping.firstName?.isEmpty ?? true) &&
                (shipping.company?.isEmpty ?? true) &&
                (shipping.address1?.isEmpty ?? true) &&
                (shipping.address2?.isEmpty ?? true) &&
                (shipping.city?.isEmpty ?? true) &&
                (shipping.postcode?.isEmpty ?? true) &&
                (shipping.country?.isEmpty ?? true);

        return _ModernAddressCard(
          title: "Shipping Address",
          actionLabel:
              isEmpty ? "Add Shipping address" : "Edit Shipping address",
          onActionTap: () {
            context.read<NavigationCubit>().selectTab(7, subTitle: 2);
          },
          fields:
              isEmpty
                  ? ["You have not set up this type of address yet."]
                  : [
                    shipping?.firstName ?? "First Name",
                    shipping?.company ?? "",
                    shipping?.address1 ?? "",
                    shipping?.address2 ?? "",
                    shipping?.city ?? "",
                    shipping?.postcode ?? "",
                    shipping?.country ?? "",
                  ],
        );
      },
    );
  }
}

class _ModernAddressCard extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback onActionTap;
  final List<String> fields;

  const _ModernAddressCard({
    required this.title,
    required this.actionLabel,
    required this.onActionTap,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width < 500 ? 14 : 22,
          vertical: width < 500 ? 14 : 28,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  color: AppColors.themeBlue,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: AppColors.themeBlue,
                      fontWeight: FontManager.bold,
                      fontSize: 19,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onActionTap,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.purple,
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  child: Text(actionLabel),
                ),
              ],
            ),
            const Divider(thickness: 1.1, height: 30),
            ...fields
                .where((line) => line.isNotEmpty)
                .map(
                  (line) => Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      line,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
