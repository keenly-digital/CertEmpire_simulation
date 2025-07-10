import 'dart:html' as html;
import 'dart:typed_data';

import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/core/shared/widgets/spaces.dart';
import 'package:certempiree/src/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:certempiree/src/order/presentation/bloc/order_bloc/order_state.dart';
import 'package:certempiree/src/simulation/presentation/bloc/download_page_bloc/download_page_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_event.dart';
import 'package:certempiree/src/simulation/presentation/widgets/download_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/shared/widgets/toast.dart';
import '../../../simulation/data/models/download_model.dart';
import '../models/order_model.dart';

class OrderDetailView extends StatelessWidget {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // This padding logic is already responsive, which is great.
    final double horizontalPadding =
        MediaQuery.of(context).size.width < 800 ? 8 : 30;

    return BlocBuilder<OrderBloc, OrderInitialState>(
      builder: (context, orderState) {
        final downloadPageBloc = context.watch<DownloadPageBloc>();
        final OrdersDetails? orderDetails = downloadPageBloc.ordersDetails;

        if (orderDetails == null) {
          return const Center(child: Text('No order details found.'));
        }
        final List<DownloadedData> downloads =
            downloadPageBloc.state.orders ?? <DownloadedData>[];
        final List<DownloadedData> matchingDownloads =
            downloads.where((d) => d.orderId == orderDetails.id).toList();

        // --- RESPONSIVE LOGIC ---
        // Use LayoutBuilder to decide which UI to show based on screen width.
        return LayoutBuilder(
          builder: (context, constraints) {
            final bool isMobile = constraints.maxWidth < 600;

            return Container(
              color: const Color(0xFFF7F8FC),
              width: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: 36,
                  horizontal: horizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Conditionally render the correct Order Info widget
                    isMobile
                        ? _buildMobileOrderInfo(orderDetails, context)
                        : _SectionCard(
                          child: _buildOrderInfo(orderDetails, context),
                        ),
                    verticalSpace(18),
                    // Conditionally render the correct Downloads Section
                    _SectionCard(
                      child:
                          isMobile
                              ? _buildMobileDownloadsSection(
                                context,
                                orderDetails,
                                matchingDownloads,
                              )
                              : _buildDownloadsSection(
                                context,
                                orderDetails,
                                matchingDownloads,
                              ),
                    ),
                    verticalSpace(18),
                    // Conditionally render the correct Order Details Section
                    _SectionCard(
                      child:
                          isMobile
                              ? _buildMobileOrderDetailsSection(
                                orderDetails,
                                matchingDownloads,
                              )
                              : _buildOrderDetailsSection(
                                orderDetails,
                                matchingDownloads,
                              ),
                    ),
                    verticalSpace(18),
                    _SectionCard(
                      child: _buildAddressBox(
                        context: context,
                        title: "Billing Address",
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderDetails.billing?.firstName ?? "",
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              orderDetails.billing?.postcode ?? "",
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              orderDetails.billing?.country ?? "",
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              orderDetails.billing?.email ?? "",
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpace(28),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal:
                    //         MediaQuery.of(context).size.width < 800 ? 2 : 4.0,
                    //   ),
                    //   child: _buildOrderAgainButton(theme.primaryColor),
                    // ),
                    // verticalSpace(20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ---- Everything below this line is TOP-LEVEL (outside any class) ----

// ===================================================================
// NEW MOBILE-FRIENDLY WIDGETS
// ===================================================================

/// Mobile version of the Order Summary section.
Widget _buildMobileOrderInfo(OrdersDetails orderDetails, BuildContext context) {
  final statusText =
      orderDetails.status == 'completed'
          ? 'Completed'
          : (orderDetails.status ?? '');
  final statusColor =
      orderDetails.status == 'completed'
          ? Colors.green[700]
          : Colors.orange[800];
  final orderDate = orderDetails.dateCreated ?? '';

  // Uses a Column layout for mobile to prevent overflow.
  return _SectionCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Summary",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: AppColors.themeBlue,
          ),
        ),
        const SizedBox(height: 16),
        // Stacks icon, text, and status vertically.
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            children: [
              TextSpan(
                text: 'Order #${orderDetails.id} ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: 'was placed on '),
              TextSpan(
                text: _formatDate(orderDate),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const TextSpan(text: ' and is currently '),
              TextSpan(
                text: '$statusText.',
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Mobile version of the Downloads section.
Widget _buildMobileDownloadsSection(
  BuildContext context,
  OrdersDetails orderDetails,
  List<DownloadedData> matchingDownloads,
) {
  if (matchingDownloads.isEmpty) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.orange[400], size: 24),
          const SizedBox(width: 10),
          const Flexible(
            child: Text(
              "No downloads available for this order.",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Converts the DataTable into a vertical list of products.
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Downloads',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 19,
          color: AppColors.themeBlue,
          letterSpacing: 0.3,
        ),
      ),
      const Divider(height: 24),
      ...matchingDownloads.map((download) {
        final lineItem = _findLineItemForDownload(orderDetails, download);
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lineItem?.name ?? download.productName ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Expires: ${download.accessExpires == null ? '-' : _formatDate(download.accessExpires)}',
                  ),
                  Text('Remaining: ${download.downloadsRemaining ?? '-'}'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DownloadActionBtn(
                    label: "Download",
                    icon: Icons.download_rounded,
                    color: AppColors.themeBlue,
                  ),
                  const SizedBox(width: 8),
                  (download.tags?.contains("with simulation") ?? false)
                      ? _ModernIconBtn(
                        icon: Icons.play_circle_fill_rounded,
                        label: "Practice",
                        color: Colors.green[600]!,
                        onTap: () {
                          AppStrings.orderId = download.orderId ?? 0;
                          AppStrings.fileId = download.fileId ?? "";
                          if (download.fileId?.isEmpty ?? true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("File ID is not available."),
                              ),
                            );
                            return;
                          }
                          context.read<SimulationBloc>().add(
                            FetchSimulationDataEvent(
                              fieldId: download.fileId ?? "",
                              pageNumber: 1,
                            ),
                          );
                          context.go("/Downloads/Simulation");
                        },
                      )
                      : SizedBox.shrink(),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    ],
  );
}

/// Mobile version of the Order Details totals section.
Widget _buildMobileOrderDetailsSection(
  OrdersDetails orderDetails,
  List<DownloadedData> matchingDownloads,
) {
  const currency = '€';

  // Converts the totals DataTable into a simple vertical list.
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Order Details',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 19,
          color: AppColors.themeBlue,
          letterSpacing: 0.3,
        ),
      ),
      const Divider(height: 24),
      ...matchingDownloads.map((download) {
        final lineItem = _findLineItemForDownload(orderDetails, download);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '${lineItem?.name ?? download.productName ?? ''} × ${lineItem?.quantity ?? 1}',
                ),
              ),
              Text(
                '${lineItem?.total ?? download.productMeta?.price ?? '0.00'} $currency',
              ),
            ],
          ),
        );
      }),
      const Divider(height: 24),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Payment method:'),
          Text(orderDetails.paymentTitle ?? 'N/A'),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
            '${orderDetails.total ?? '0.00'} $currency EUR',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    ],
  );
}

// ===================================================================
// ORIGINAL WIDGETS FOR DESKTOP (UNCHANGED)
// ===================================================================

Widget _buildAddressBox({
  required BuildContext context,
  required String title,
  required Widget content,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: context.textTheme.titleLarge?.copyWith(
          color: AppColors.themeBlue,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          fontSize: 18,
        ),
      ),
      const Divider(thickness: 1.1, height: 22),
      content,
    ],
  );
}

class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14365788),
            blurRadius: 24,
            offset: Offset(0, 6),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: child,
      ),
    );
  }
}

Widget _buildOrderInfo(OrdersDetails orderDetails, BuildContext context) {
  final statusText =
      orderDetails.status == 'completed'
          ? 'Completed'
          : (orderDetails.status ?? '');
  final statusColor =
      orderDetails.status == 'completed'
          ? Colors.green[700]
          : Colors.orange[800];
  final orderDate = orderDetails.dateCreated ?? '';

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Order Summary",
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: AppColors.themeBlue,
        ),
      ),
      const SizedBox(height: 16),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.themeBlue.withOpacity(0.13),
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.all(11),
            child: Icon(
              Icons.receipt_long_rounded,
              color: AppColors.themeBlue,
              size: 30,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                children: [
                  TextSpan(
                    text: 'Order #${orderDetails.id} ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: 'was placed on '),
                  TextSpan(
                    text: _formatDate(orderDate),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const TextSpan(text: ' and is currently '),
                  TextSpan(
                    text: '$statusText.',
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildDownloadsSection(
  BuildContext context,
  OrdersDetails orderDetails,
  List<DownloadedData> matchingDownloads,
) {
  if (matchingDownloads.isEmpty) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.orange[400], size: 24),
          const SizedBox(width: 10),
          const Text(
            "No downloads available for this order.",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Downloads',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 19,
          color: AppColors.themeBlue,
          letterSpacing: 0.3,
        ),
      ),
      const SizedBox(height: 18),
      ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                      const Color(0xFFF4F6FB),
                    ),
                    dataRowMinHeight: 52,
                    dataRowMaxHeight: 60,
                    headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.5,
                      color: Color(0xFF1F2233),
                      letterSpacing: 0.15,
                    ),
                    columns: const [
                      DataColumn(label: Text('Product')),
                      DataColumn(label: Text('Remaining')),
                      DataColumn(label: Text('Expires')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows:
                        matchingDownloads.map((download) {
                          final lineItem = _findLineItemForDownload(
                            orderDetails,
                            download,
                          );
                          return DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  lineItem?.name ?? download.productName ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  download.downloadsRemaining?.toString() ??
                                      '-',
                                ),
                              ),
                              DataCell(
                                download.accessExpires == null
                                    ? const Text('-')
                                    : Text(_formatDate(download.accessExpires)),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    DownloadActionBtn(
                                      label: "Download",
                                      icon: Icons.download_rounded,
                                      color: AppColors.themeBlue,
                                    ),
                                    const SizedBox(width: 8),
                                    (download.tags?.contains(
                                              "with simulation",
                                            ) ??
                                            false)
                                        ? _ModernIconBtn(
                                          icon: Icons.play_circle_fill_rounded,
                                          label: "Practice",
                                          color: Colors.green[600]!,
                                          onTap: () {
                                            if (download.fileId?.isEmpty ??
                                                true) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "File ID is not available.",
                                                  ),
                                                ),
                                              );
                                              return;
                                            }
                                            AppStrings.fileId =
                                                download.fileId ?? "";
                                            context.read<SimulationBloc>().add(
                                              FetchSimulationDataEvent(
                                                fieldId: download.fileId ?? "",
                                                pageNumber: 1,
                                              ),
                                            );
                                            context.go("/Downloads/Simulation");
                                          },
                                        )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

Widget _buildOrderDetailsSection(
  OrdersDetails orderDetails,
  List<DownloadedData> matchingDownloads,
) {
  const currency = '€';

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Order Details',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 19,
          color: AppColors.themeBlue,
          letterSpacing: 0.3,
        ),
      ),
      const SizedBox(height: 18),
      ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                      const Color(0xFFF4F6FB),
                    ),
                    dataRowMinHeight: 52,
                    dataRowMaxHeight: 60,
                    headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.5,
                      color: Color(0xFF1F2233),
                      letterSpacing: 0.15,
                    ),
                    columns: const [
                      DataColumn(label: Text('Product')),
                      DataColumn(label: Text('Total')),
                    ],
                    rows: [
                      ...matchingDownloads.map((download) {
                        final lineItem = _findLineItemForDownload(
                          orderDetails,
                          download,
                        );
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                '${lineItem?.name ?? download.productName ?? ''} × ${lineItem?.quantity ?? 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${lineItem?.total ?? download.productMeta?.price ?? '0.00'} $currency',
                              ),
                            ),
                          ],
                        );
                      }),
                      DataRow(
                        cells: [
                          const DataCell(Text('Payment method:')),
                          DataCell(Text(orderDetails.paymentTitle ?? 'N/A')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          const DataCell(
                            Text(
                              'Total:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataCell(
                            Text(
                              '${orderDetails.total ?? '0.00'} $currency EUR',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

// Widget _buildOrderAgainButton(Color primaryColor) {
//   return OutlinedButton.icon(
//     icon: const Icon(Icons.shopping_cart_checkout_rounded),
//     style: OutlinedButton.styleFrom(
//       foregroundColor: primaryColor,
//       backgroundColor: const Color(0xFFF2F5FD),
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
//       side: BorderSide(color: primaryColor.withOpacity(0.26), width: 1.2),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
//       textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//     ),
//     onPressed: () {},
//     label: const Text('Order again'),
//   );
// }

class _ModernIconBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ModernIconBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: color,
        backgroundColor: color.withOpacity(0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: const Size(34, 40),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      onPressed: onTap,
    );
  }
}

String _formatDate(String? isoTimestamp) {
  if (isoTimestamp == null || isoTimestamp.isEmpty) return '';
  try {
    final dateTime = DateTime.parse(isoTimestamp);
    return DateFormat('MMMM d, yyyy').format(dateTime);
  } catch (_) {
    return isoTimestamp;
  }
}

LineItem? _findLineItemForDownload(
  OrdersDetails orderDetails,
  DownloadedData download,
) {
  try {
    return orderDetails.lineItems?.firstWhere(
      (li) => li.productId == download.productId,
    );
  } catch (_) {
    return null;
  }
}
