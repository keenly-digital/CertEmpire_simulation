import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/font_manager.dart';
import 'package:certempiree/src/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/download_page_bloc/download_page_bloc.dart';
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
    final orderList = orders ?? [];

    if (orderList.isEmpty) {
      return Center(
        child: Text("No orders found.", style: context.textTheme.titleLarge),
      );
    }

    // --- SINGLE ORDER: Show as card ---
    if (orderList.length == 1) {
      final order = orderList.first;
      final statusColor =
          (order.status == 'completed')
              ? Colors.green[700]
              : AppColors.themeBlue;

      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        elevation: 2.5,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order number and status
              Row(
                children: [
                  Icon(
                    Icons.receipt_long_rounded,
                    color: AppColors.themeBlue,
                    size: 28,
                  ),
                  const SizedBox(width: 14),
                  Text(
                    '#${order.id}',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: AppColors.themeBlue,
                      fontWeight: FontManager.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: statusColor!.withOpacity(0.11),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Text(
                      order.status ?? "",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: statusColor,
                        fontWeight: FontManager.semiBold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.grey[600], size: 18),
                  const SizedBox(width: 8),
                  Text(
                    convertDate(order.dateCreated ?? ""),
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: AppColors.themeBlue,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      getProductNames(order),
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontManager.bold,
                        fontSize: 15.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    "${formatCurrency(double.parse(order.total ?? "0"), "${order.currency}")} ${order.currency ?? ''}",
                    style: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.themeBlue,
                      fontWeight: FontManager.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  OutlinedButton.icon(
                    icon: Icon(Icons.visibility_rounded),
                    label: Text("View Details"),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.themeBlue.withOpacity(0.13),
                      foregroundColor: AppColors.themeBlue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 11,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      context.read<DownloadPageBloc>().ordersDetails = order;
                      context.read<NavigationCubit>().selectTab(1, subTitle: 1);
                    },
                  ),
                  // Add more action buttons if needed
                ],
              ),
            ],
          ),
        ),
      );
    }

    // --- MULTIPLE ORDERS: Show as table ---
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      elevation: 2.5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Table(
            border: TableBorder(
              horizontalInside: BorderSide(
                color: Colors.grey.shade100,
                width: 1,
              ),
            ),
            columnWidths: const {
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(2),
              4: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // Header row
              TableRow(
                decoration: BoxDecoration(
                  color: AppColors.themeBlue.withOpacity(0.08),
                ),
                children: [
                  _headerCell(context, 'Order'),
                  _headerCell(context, 'Date'),
                  _headerCell(context, 'Status'),
                  _headerCell(context, 'Total'),
                  _headerCell(context, 'Actions'),
                ],
              ),
              // Data rows
              ...orderList.asMap().entries.map((entry) {
                final index = entry.key;
                final order = entry.value;
                final isEven = index % 2 == 0;
                final statusColor =
                    (order.status == 'completed')
                        ? Colors.green[700]
                        : AppColors.themeBlue;

                return TableRow(
                  decoration: BoxDecoration(
                    color: isEven ? Colors.grey[50] : Colors.white,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      child: InkWell(
                        onTap: () {
                          context.read<NavigationCubit>().selectTab(
                            1,
                            subTitle: 1,
                          );
                        },
                        child: Text(
                          '#${order.id}',
                          style: context.textTheme.labelMedium?.copyWith(
                            color: AppColors.lightPrimary,
                            fontWeight: FontManager.semiBold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      child: Text(
                        convertDate(order.dateCreated ?? ""),
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontManager.regular,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: statusColor!.withOpacity(0.11),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Text(
                              order.status ?? "",
                              style: context.textTheme.bodySmall?.copyWith(
                                color: statusColor,
                                fontWeight: FontManager.semiBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      child: Text(
                        "${formatCurrency(double.parse(order.total ?? "0"), "${order.currency}")} ${order.currency ?? ''} for ${order.lineItems?.length ?? ''}",
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontManager.regular,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            context.read<DownloadPageBloc>().ordersDetails =
                                order;
                            context.read<NavigationCubit>().selectTab(
                              1,
                              subTitle: 1,
                            );
                          },
                          borderRadius: BorderRadius.circular(22),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.themeBlue,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.themeBlue.withOpacity(0.11),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 22,
                            ),
                            child: Text(
                              "View",
                              style: context.textTheme.labelMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontManager.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerCell(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
      child: Text(
        text,
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontManager.bold,
          color: AppColors.themeBlue,
          letterSpacing: 0.3,
        ),
      ),
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

  String formatCurrency(num amount, String currencyCode) {
    final currencyLocaleMap = {
      'USD': 'en_US',
      'EUR': 'fr_FR',
      'GBP': 'en_GB',
      'JPY': 'ja_JP',
      'CNY': 'zh_CN',
      'INR': 'hi_IN',
      'PKR': 'ur_PK',
      'AUD': 'en_AU',
      'CAD': 'en_CA',
      'CHF': 'de_CH',
      'SEK': 'sv_SE',
      'NOK': 'nb_NO',
      'DKK': 'da_DK',
      'RUB': 'ru_RU',
      'BRL': 'pt_BR',
      'MXN': 'es_MX',
      'ZAR': 'en_ZA',
      'TRY': 'tr_TR',
      'SAR': 'ar_SA',
      'AED': 'ar_AE',
      'SGD': 'en_SG',
      'HKD': 'zh_HK',
      'KRW': 'ko_KR',
      'THB': 'th_TH',
      'IDR': 'id_ID',
      'MYR': 'ms_MY',
      'PLN': 'pl_PL',
      'CZK': 'cs_CZ',
      'HUF': 'hu_HU',
      'ILS': 'he_IL',
      'EGP': 'ar_EG',
      'NGN': 'en_NG',
      'BDT': 'bn_BD',
      'LKR': 'si_LK',
      'VND': 'vi_VN',
    };

    final locale = currencyLocaleMap[currencyCode] ?? 'en';
    final format = NumberFormat.simpleCurrency(
      locale: locale,
      name: currencyCode,
    );
    return format.format(amount);
  }

  String getProductNames(OrdersDetails order) {
    if (order.lineItems == null || order.lineItems!.isEmpty) return "—";
    return order.lineItems!
        .map((li) => li.name)
        .where((name) => name != null && name.isNotEmpty)
        .join(', ');
  }
}
