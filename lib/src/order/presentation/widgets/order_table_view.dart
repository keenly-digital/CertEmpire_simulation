/// @Author: Ehsan
/// @Email: muhammad.ehsan@barq.com.pk
/// @Date: 25/06/2025

import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../main/presentation/bloc/navigation_cubit.dart';
import '../models/order_model.dart';

class OrderTableView extends StatelessWidget {
  const OrderTableView({super.key, required this.orders});

  final List<OrdersDetails>? orders;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(2), // Slightly more horizontal space for 'Total'
        4: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        // Header row
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade50),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14.0),
              child: Text(
                'Order',
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontManager.semiBold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Date',
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontManager.semiBold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Status',
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontManager.semiBold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Total',
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontManager.semiBold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Actions',
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontManager.semiBold,
                ),
              ),
            ),
          ],
        ),
        // Data rows
        ...orders!.map(
          (order) => TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '#${order.id}',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: AppColors.lightPrimary,
                    fontWeight: FontManager.semiBold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  convertDate(order.dateCreated ?? ""),
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontManager.regular,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  order.status ?? "",
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontManager.regular,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  order.total ?? "",
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontManager.regular,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<NavigationCubit>().selectTab(1 , subTitle: 1);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 90,
                        maxHeight: 44,
                        minHeight: 44,
                        minWidth: 40,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.lightPrimary,
                          // Use your exact blue/purple
                          borderRadius: BorderRadius.circular(
                            1,
                          ), // Slightly rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8,
                        ),
                        child: Center(
                          child: Text(
                            "View",
                            style: context.textTheme.labelMedium?.copyWith(
                              color: AppColors.lightBackgroundpurple,
                              fontWeight: FontManager.semiBold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String convertDate(String isoTimestamp) {
    try {
      final dateTime = DateTime.parse(isoTimestamp);
      return DateFormat('MMMM d, yyyy').format(dateTime);
    } catch (_) {
      return '';
    }
  }
}
