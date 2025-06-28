import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/font_manager.dart';
import 'package:certempiree/core/routes/app_route.dart';
import 'package:certempiree/src/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/download_page_bloc/download_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.r),
        ),
        elevation: 2.5,
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: minDouble(32.w, 40),
            vertical: minDouble(28.h, 32),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order number and status
              Row(
                children: [
                  Icon(
                    Icons.receipt_long_rounded,
                    color: AppColors.themeBlue,
                    size: minDouble(28.sp, 30),
                  ),
                  SizedBox(width: minDouble(14.w, 16)),
                  Text(
                    '#${order.id}',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: AppColors.themeBlue,
                      fontWeight: FontManager.bold,
                      fontSize: minDouble(18.sp, 20),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: statusColor!.withOpacity(0.11),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: minDouble(12.w, 16),
                      vertical: minDouble(6.h, 8),
                    ),
                    child: Text(
                      order.status ?? "",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: statusColor,
                        fontWeight: FontManager.semiBold,
                        fontSize: minDouble(13.sp, 15),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: minDouble(18.h, 18)),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.grey[600],
                    size: minDouble(18.sp, 18),
                  ),
                  SizedBox(width: minDouble(8.w, 8)),
                  Text(
                    convertDate(order.dateCreated ?? ""),
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: minDouble(13.sp, 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: minDouble(16.h, 16)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: AppColors.themeBlue,
                    size: minDouble(22.sp, 22),
                  ),
                  SizedBox(width: minDouble(10.w, 10)),
                  Expanded(
                    child: Text(
                      getProductNames(order),
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontManager.bold,
                        fontSize: minDouble(15.5.sp, 16),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: minDouble(15.w, 15)),
                  Text(
                    "${formatCurrency(double.parse(order.total ?? "0"), "${order.currency}")} ${order.currency ?? ''}",
                    style: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.themeBlue,
                      fontWeight: FontManager.bold,
                      fontSize: minDouble(17.sp, 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: minDouble(24.h, 24)),
              Row(
                children: [
                  OutlinedButton.icon(
                    icon: Icon(
                      Icons.visibility_rounded,
                      size: minDouble(18.sp, 20),
                    ),
                    label: Text("View Details"),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.themeBlue.withOpacity(0.13),
                      foregroundColor: AppColors.themeBlue,
                      padding: EdgeInsets.symmetric(
                        horizontal: minDouble(22.w, 26),
                        vertical: minDouble(11.h, 13),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.r),
                      ),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: minDouble(14.sp, 15),
                      ),
                    ),
                    onPressed: () {
                      context.read<DownloadPageBloc>().ordersDetails = order;
                      context.go("/Orders/OrderDetail");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // --- MULTIPLE ORDERS: Show as table (desktop/tablet) or list (mobile) ---
    if (isMobile) {
      // --- Mobile: List Cards ---
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          final order = orderList[index];
          final statusColor =
              (order.status == 'completed')
                  ? Colors.green[700]
                  : AppColors.themeBlue;
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 1.8,
            margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_long,
                        color: AppColors.themeBlue,
                        size: minDouble(20.sp, 22),
                      ),
                      SizedBox(width: minDouble(8.w, 8)),
                      Text(
                        '#${order.id}',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: AppColors.themeBlue,
                          fontWeight: FontManager.bold,
                          fontSize: minDouble(16.sp, 16),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: statusColor!.withOpacity(0.11),
                          borderRadius: BorderRadius.circular(7.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: minDouble(10.w, 11),
                          vertical: minDouble(5.h, 7),
                        ),
                        child: Text(
                          order.status ?? "",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: statusColor,
                            fontWeight: FontManager.semiBold,
                            fontSize: minDouble(12.sp, 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: minDouble(8.h, 8)),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: minDouble(14.sp, 14),
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: minDouble(4.w, 4)),
                      Text(
                        convertDate(order.dateCreated ?? ""),
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: minDouble(12.sp, 13),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: minDouble(8.h, 8)),
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_bag,
                        size: minDouble(16.sp, 16),
                        color: AppColors.themeBlue,
                      ),
                      SizedBox(width: minDouble(4.w, 4)),
                      Expanded(
                        child: Text(
                          getProductNames(order),
                          style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontManager.bold,
                            fontSize: minDouble(13.sp, 14),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: minDouble(6.h, 6)),
                  Text(
                    "${formatCurrency(double.parse(order.total ?? "0"), "${order.currency}")} ${order.currency ?? ''} for ${order.lineItems?.length ?? ''}",
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontManager.regular,
                      color: Colors.black87,
                      fontSize: minDouble(13.sp, 14),
                    ),
                  ),
                  SizedBox(height: minDouble(12.h, 12)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<DownloadPageBloc>().ordersDetails = order;
                        context.go("/Orders/OrderDetail");
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.themeBlue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: minDouble(16.w, 18),
                          vertical: minDouble(8.h, 10),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: minDouble(13.sp, 13),
                        ),
                      ),
                      child: Text("View"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    // --- Tablet/Desktop: Table ---
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.r)),
      elevation: 2.5,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: minDouble(8.w, 16),
          vertical: minDouble(12.h, 20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: minDouble(8.w, 8),
                        vertical: minDouble(12.h, 12),
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
                            fontSize: minDouble(15.sp, 16),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: minDouble(8.w, 8),
                        vertical: minDouble(12.h, 12),
                      ),
                      child: Text(
                        convertDate(order.dateCreated ?? ""),
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontManager.regular,
                          color: Colors.black87,
                          fontSize: minDouble(14.sp, 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: minDouble(8.w, 8),
                        vertical: minDouble(12.h, 12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: statusColor!.withOpacity(0.11),
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: minDouble(10.w, 10),
                              vertical: minDouble(5.h, 7),
                            ),
                            child: Text(
                              order.status ?? "",
                              style: context.textTheme.bodySmall?.copyWith(
                                color: statusColor,
                                fontWeight: FontManager.semiBold,
                                fontSize: minDouble(13.sp, 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: minDouble(8.w, 8),
                        vertical: minDouble(12.h, 12),
                      ),
                      child: Text(
                        "${formatCurrency(double.parse(order.total ?? "0"), "${order.currency}")} ${order.currency ?? ''} for ${order.lineItems?.length ?? ''}",
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontManager.regular,
                          color: Colors.black87,
                          fontSize: minDouble(14.sp, 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: minDouble(8.w, 8),
                        vertical: minDouble(10.h, 10),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            context.read<DownloadPageBloc>().ordersDetails =
                                order;

                            context.go("/Orders/OrderDetail");
                          },
                          borderRadius: BorderRadius.circular(18.r),
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: 70.w,
                              maxWidth: 120.w,
                              minHeight: 36.h,
                              maxHeight: 44.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.themeBlue,
                              borderRadius: BorderRadius.circular(18.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.themeBlue.withOpacity(0.09),
                                  blurRadius: 6,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              vertical: minDouble(7.h, 11),
                              horizontal: 0,
                            ),
                            child: Text(
                              "View",
                              style: context.textTheme.labelMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontManager.bold,
                                fontSize: minDouble(14.sp, 15),
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
      padding: EdgeInsets.symmetric(
        vertical: minDouble(13.h, 17),
        horizontal: minDouble(10.w, 12),
      ),
      child: Text(
        text,
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontManager.bold,
          color: AppColors.themeBlue,
          letterSpacing: 0.3,
          fontSize: minDouble(17.sp, 19),
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

  // Helper for minDouble (capping .sp/.w/etc.)
  double minDouble(double a, double b) => (a < b) ? a : b;
}
