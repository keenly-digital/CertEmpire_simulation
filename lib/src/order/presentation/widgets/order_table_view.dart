/// @Author: Ehsan
/// @Email: muhammad.ehsan@barq.com.pk
/// @Date: 25/06/2025

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
                child: InkWell(
                  onTap: () {
                    context.read<NavigationCubit>().selectTab(1, subTitle: 1);
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
                  "${formatCurrency(double.parse(order.total ?? "0"), "${order.currency}")} ${order.currency ?? ''} for ${order.lineItems?.length ?? ''}",
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontManager.regular,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<DownloadPageBloc>().ordersDetails = order;
                  context.read<NavigationCubit>().selectTab(1, subTitle: 1);
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

  String formatCurrency(num amount, String currencyCode) {
    final currencyLocaleMap = {
      'USD': 'en_US', // US Dollar
      'EUR': 'fr_FR', // Euro (France - symbol after amount)
      'GBP': 'en_GB', // British Pound
      'JPY': 'ja_JP', // Japanese Yen
      'CNY': 'zh_CN', // Chinese Yuan
      'INR': 'hi_IN', // Indian Rupee
      'PKR': 'ur_PK', // Pakistani Rupee
      'AUD': 'en_AU', // Australian Dollar
      'CAD': 'en_CA', // Canadian Dollar
      'CHF': 'de_CH', // Swiss Franc
      'SEK': 'sv_SE', // Swedish Krona
      'NOK': 'nb_NO', // Norwegian Krone
      'DKK': 'da_DK', // Danish Krone
      'RUB': 'ru_RU', // Russian Ruble
      'BRL': 'pt_BR', // Brazilian Real
      'MXN': 'es_MX', // Mexican Peso
      'ZAR': 'en_ZA', // South African Rand
      'TRY': 'tr_TR', // Turkish Lira
      'SAR': 'ar_SA', // Saudi Riyal
      'AED': 'ar_AE', // UAE Dirham
      'SGD': 'en_SG', // Singapore Dollar
      'HKD': 'zh_HK', // Hong Kong Dollar
      'KRW': 'ko_KR', // South Korean Won
      'THB': 'th_TH', // Thai Baht
      'IDR': 'id_ID', // Indonesian Rupiah
      'MYR': 'ms_MY', // Malaysian Ringgit
      'PLN': 'pl_PL', // Polish Zloty
      'CZK': 'cs_CZ', // Czech Koruna
      'HUF': 'hu_HU', // Hungarian Forint
      'ILS': 'he_IL', // Israeli Shekel
      'EGP': 'ar_EG', // Egyptian Pound
      'NGN': 'en_NG', // Nigerian Naira
      'BDT': 'bn_BD', // Bangladeshi Taka
      'LKR': 'si_LK', // Sri Lankan Rupee
      'VND': 'vi_VN', // Vietnamese Dong
      // Add more as needed
    };

    final locale = currencyLocaleMap[currencyCode] ?? 'en';

    final format = NumberFormat.simpleCurrency(
      locale: locale,
      name: currencyCode,
    );

    return format.format(amount);
  }
}
