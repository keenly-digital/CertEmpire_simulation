import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/shared/widgets/spaces.dart';
import 'package:certempiree/src/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:certempiree/src/order/presentation/bloc/order_bloc/order_state.dart';
import 'package:certempiree/src/simulation/presentation/bloc/download_page_bloc/download_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/font_manager.dart';
import '../../../simulation/data/models/download_model.dart';
import '../models/order_model.dart';

/// Main order detail view
class OrderDetailView extends StatelessWidget {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderInitialState>(
      builder: (context, orderState) {
        final downloadPageBloc = context.watch<DownloadPageBloc>();
        final OrdersDetails orderDetails = downloadPageBloc.ordersDetails;
        final List<DownloadedData> downloads =
            downloadPageBloc.state.orders ?? <DownloadedData>[];

        // Get downloads for this order only
        final List<DownloadedData> matchingDownloads =
            downloads.where((d) => d.orderId == orderDetails.id).toList();

        final theme = Theme.of(context);
        final primaryColor = theme.primaryColor;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildOrderInfo(orderDetails),
              const SizedBox(height: 24),
              _buildDownloadsSection(
                orderDetails,
                matchingDownloads,
                primaryColor,
              ),
              const SizedBox(height: 32),
              _buildOrderDetailsSection(orderDetails, matchingDownloads),
              const SizedBox(height: 32),
              _buildOrderAgainButton(primaryColor),
              verticalSpace(10),
              _buildAddressBox(
                context: context,
                title: "Billing address",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderDetails.billing?.firstName ?? "",
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Text(
                      orderDetails.billing?.postcode ?? "",
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Text(
                      orderDetails.billing?.country ?? "",
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Text(
                      orderDetails.billing?.email ?? "",
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddressBox({
    required BuildContext context,
    required String title,
    required Widget content,
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
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }
}

Widget _buildOrderInfo(OrdersDetails orderDetails) {
  final statusText =
      orderDetails.status == 'completed'
          ? 'Completed'
          : orderDetails.status ?? '';
  final statusColor =
      orderDetails.status == 'completed' ? Colors.green : Colors.orange;
  final orderDate = orderDetails.dateCreated ?? '';
  return Text.rich(
    TextSpan(
      text: 'Order #${orderDetails.id} ',
      children: [
        const TextSpan(
          text: 'was placed on ',
          style: TextStyle(color: Colors.black),
        ),
        TextSpan(
          text: _formatDate(orderDate),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextSpan(
          text: ' and is currently ',
          style: TextStyle(color: Colors.black),
        ),
        TextSpan(
          text: '$statusText.',
          style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
        ),
      ],
      style: const TextStyle(fontSize: 16),
    ),
  );
}

Widget _buildDownloadsSection(
  OrdersDetails orderDetails,
  List<DownloadedData> matchingDownloads,
  Color primaryColor,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Downloads',
        style: TextStyle(
          fontSize: 20,
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 12),
      Table(
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(3),
        },
        border: TableBorder.all(color: Colors.grey),
        children: [
          _buildTableRow(
            isHeader: true,
            values: const [
              'Product',
              'Downloads remaining',
              'Expires',
              'Download',
            ],
          ),
          ...matchingDownloads.map((download) {
            final lineItem = _findLineItemForDownload(orderDetails, download);
            return _buildTableRow(
              values: [
                lineItem?.name ?? download.productName ?? '',
                download.downloadsRemaining?.toString() ?? '',
                _formatDate(download.accessExpires),
                '',
              ],
              buttons: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    // Download logic here, e.g. launch URL
                    if (download.fileUrl != null &&
                        download.fileUrl!.isNotEmpty) {
                      // TODO: Use url_launcher or similar package to download
                    }
                  },
                  child: Text('Download'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    // Practice online logic here
                  },
                  child: const Text('Practice Online'),
                ),
              ],
            );
          }).toList(),
        ],
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
      const Text(
        'Order details',
        style: TextStyle(
          fontSize: 20,
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 12),
      Table(
        columnWidths: const {0: FlexColumnWidth(6), 1: FlexColumnWidth(2)},
        border: TableBorder.all(color: Colors.grey),
        children: [
          const TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Product',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          ...matchingDownloads.map((download) {
            final lineItem = _findLineItemForDownload(orderDetails, download);
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '${lineItem?.name ?? download.productName ?? ''} × ${lineItem?.quantity ?? 1}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '${lineItem?.total ?? download.productMeta?.price ?? '0.00'} $currency',
                  ),
                ),
              ],
            );
          }).toList(),
          TableRow(
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text('Payment method:'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(orderDetails.paymentTitle ?? 'N/A'),
              ),
            ],
          ),
          TableRow(
            children: [
              const Padding(padding: EdgeInsets.all(8), child: Text('Total:')),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text('${orderDetails.total ?? '0.00'} $currency EUR'),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget _buildOrderAgainButton(Color primaryColor) {
  return Align(
    alignment: Alignment.centerLeft,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: () {},
      child: const Text('Order again'),
    ),
  );
}

TableRow _buildTableRow({
  required List<String> values,
  bool isHeader = false,
  List<Widget>? buttons,
}) {
  return TableRow(
    children:
        values.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;

          if (index == values.length - 1 && buttons != null) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(children: buttons),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style:
                  isHeader
                      ? const TextStyle(fontWeight: FontWeight.bold)
                      : const TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
  );
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

/// Helper: get the line item from order for a download
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
