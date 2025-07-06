import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/font_manager.dart';
import 'package:certempiree/src/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/download_page_bloc/download_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    if (orderList.isEmpty) {
      return Center(
        child: Text("No orders found.", style: context.textTheme.titleLarge),
      );
    }

    // --- RESPONSIVE LOGIC ---
    return LayoutBuilder(
      builder: (context, constraints) {
        // I've increased the breakpoint to 800px for a better experience on tablets.
        if (constraints.maxWidth < 800) {
          return _buildMobileListView(context, orderList);
        } else {
          return _buildDesktopView(context, orderList);
        }
      },
    );
  }

  // --- WIDGET FOR SMALL SCREENS (< 800px) ---
  /// Builds a vertical Column of cards.
  Widget _buildMobileListView(
    BuildContext context,
    List<OrdersDetails> orderList,
  ) {
    // MODIFIED: Replaced ListView.builder with a simple Column.
    // The parent layout in main_page_view.dart will handle all scrolling.
    return Column(
      children:
          orderList.map((order) {
            // The following is the Card widget from your original itemBuilder.
            final statusColor =
                (order.status == 'completed')
                    ? Colors.green[700]
                    : AppColors.themeBlue;

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '#${order.id}',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: AppColors.themeBlue,
                            fontWeight: FontManager.bold,
                          ),
                        ),
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
                    const SizedBox(height: 8),
                    Text(
                      convertDate(order.dateCreated ?? ""),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const Divider(height: 24),
                    Text(
                      getProductNames(order),
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontManager.semiBold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${formatCurrency(double.parse(order.total ?? "0"), "${order.currency}")} ${order.currency ?? ''}",
                      style: context.textTheme.titleMedium?.copyWith(
                        color: AppColors.themeBlue,
                        fontWeight: FontManager.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          context.read<DownloadPageBloc>().ordersDetails =
                              order;
                          context.go("/Orders/OrderDetail");
                        },
                        borderRadius: BorderRadius.circular(22),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.themeBlue,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 24,
                          ),
                          child: Text(
                            "View",
                            style: context.textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(), // .toList() is important to convert the map to a list of widgets
    );
  }

  // --- WIDGET FOR LARGE SCREENS (>= 800px) ---
  /// Contains the logic for showing a single detailed card or a flexible table.
  Widget _buildDesktopView(
    BuildContext context,
    List<OrdersDetails> orderList,
  ) {
    if (orderList.length == 1) {
      // Logic for single order remains the same, it's generally safe.
      return _buildSingleOrderCard(context, orderList.first);
    }

    // **FIX for overflowing content**: Replaced the rigid `Table` with a
    // flexible layout using a Column of Rows with Expanded widgets.
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      elevation: 2.5,
      color: Colors.white,
      child: Column(
        children: [
          // Custom Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.themeBlue.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Row(
              children: [
                Expanded(flex: 2, child: _headerCell(context, 'Order')),
                Expanded(flex: 3, child: _headerCell(context, 'Date')),
                Expanded(flex: 3, child: _headerCell(context, 'Status')),
                Expanded(flex: 4, child: _headerCell(context, 'Total')),
                Expanded(flex: 2, child: _headerCell(context, 'Actions')),
              ],
            ),
          ),
          // Table Rows
          ...orderList.map((order) => _buildFlexibleDataRow(context, order)),
        ],
      ),
    );
  }

  /// A single flexible data row for the desktop table.
  Widget _buildFlexibleDataRow(BuildContext context, OrdersDetails order) {
    final statusColor =
        (order.status == 'completed') ? Colors.green[700] : AppColors.themeBlue;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Order
          Expanded(
            flex: 2,
            child: Text(
              '#${order.id}',
              style: context.textTheme.labelMedium?.copyWith(
                color: AppColors.lightPrimary,
                fontWeight: FontManager.semiBold,
              ),
            ),
          ),
          // Date
          Expanded(
            flex: 3,
            child: Text(
              convertDate(order.dateCreated ?? ""),
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontManager.regular,
                color: Colors.black87,
              ),
            ),
          ),
          // Status
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
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
            ),
          ),
          // Total
          Expanded(
            flex: 4,
            child: Text(
              "${formatCurrency(double.parse(order.total ?? "0"), "${order.currency}")} ${order.currency ?? ''} for ${order.lineItems?.length ?? ''} item(s)",
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontManager.regular,
                color: Colors.black87,
              ),
            ),
          ),
          // Actions
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  context.read<DownloadPageBloc>().ordersDetails = order;
                  context.go("/Orders/OrderDetail");
                },
                borderRadius: BorderRadius.circular(22),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.themeBlue,
                    borderRadius: BorderRadius.circular(22),
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
      ),
    );
  }

  /// The original card view for a single order, extracted for clarity.
  Widget _buildSingleOrderCard(BuildContext context, OrdersDetails order) {
    final statusColor =
        (order.status == 'completed') ? Colors.green[700] : AppColors.themeBlue;

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
            Row(
              children: [
                const Icon(
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
                const Icon(
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
                  icon: const Icon(Icons.visibility_rounded),
                  label: const Text("View Details"),
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

  // --- HELPER WIDGETS AND FUNCTIONS (Unchanged) ---
  Widget _headerCell(BuildContext context, String text) {
    return Text(
      text,
      style: context.textTheme.titleSmall?.copyWith(
        fontWeight: FontManager.bold,
        color: AppColors.themeBlue,
        letterSpacing: 0.3,
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
