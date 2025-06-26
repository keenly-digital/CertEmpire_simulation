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


/// zohaib
class OrderDetailView extends StatelessWidget {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // var list = context.read<OrderBloc>().state.orders?.where((element) {
    //   return element.id == context.read<DownloadPageBloc>().ordersDetails.id;
    // });

    return BlocBuilder<OrderBloc, OrderInitialState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final downloadPageBloc = context.read<DownloadPageBloc>();
        final orderDetails = downloadPageBloc.ordersDetails;
        final primaryColor = theme.primaryColor;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildOrderInfo(primaryColor),
              const SizedBox(height: 24),
              _buildDownloadsSection(primaryColor, state, context),
              const SizedBox(height: 32),
              _buildOrderDetailsSection(context, state),
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

Widget _buildOrderInfo(Color primaryColor) {
  return Text.rich(
    TextSpan(
      text: 'Order #41383 ',
      children: [
        const TextSpan(
          text: 'was placed on ',
          style: TextStyle(color: Colors.black),
        ),
        const TextSpan(
          text: 'June 24, 2025 ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const TextSpan(
          text: 'and is currently ',
          style: TextStyle(color: Colors.black),
        ),
        TextSpan(
          text: 'Completed.',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ],
      style: const TextStyle(fontSize: 16),
    ),
  );
}

Widget _buildDownloadsSection(
  Color primaryColor,
  OrderInitialState state,
  BuildContext context,
) {
  final downloadPageBloc = context.read<DownloadPageBloc>();
  final orderDetails = downloadPageBloc.ordersDetails;
  final matchingDownloads =
      downloadPageBloc.state.orders
          ?.where((download) => download.productId == orderDetails.id)
          .toList();

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
          ...?matchingDownloads?.map((download) {
            final lineItem = _findMatchingUpper(
              state,
              download.orderId,
              context,
            );

            return _buildTableRow(
              values: [
                lineItem?.productName ?? '',
                download.downloadsRemaining?.toString() ?? '',
                _formatDate(download.accessExpires?.toString()),
                '',
              ],
              buttons: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {},
                  child: Text(lineItem?.productName ?? 'Download'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {},
                  child: const Text('Practice Online'),
                ),
              ],
            );
          }),
        ],
      ),
    ],
  );
}

Widget _buildOrderDetailsSection(
  BuildContext context,
  OrderInitialState state,
) {
  final downloadPageBloc = context.read<DownloadPageBloc>();
  final orderDetails = downloadPageBloc.ordersDetails;
  final matchingDownloads =
      downloadPageBloc.state.orders
          ?.where((download) => download.orderId == orderDetails.id)
          .toList();

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
          ...?matchingDownloads?.map((download) {
            final lineItem = _findMatchingLineItem(state, download.orderId);

            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '${lineItem?.name ?? 'Unknown Product'} × ${lineItem?.quantity ?? 1}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text('${lineItem?.total ?? '0.00'} $currency'),
                ),
              ],
            );
          }),
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
  if (isoTimestamp == null) return '';

  try {
    final dateTime = DateTime.parse(isoTimestamp);
    return DateFormat('MMMM d, yyyy').format(dateTime);
  } catch (_) {
    return '';
  }
}

LineItem? _findMatchingLineItem(OrderInitialState state, int? productId) {
  debugPrint('No matching line item found for productId11111: $productId');

  final matchingItem =
      state.orders?.expand((order) => order.lineItems ?? []).where((item) {
        print("sdlsakd880 ${item}");
        return item.productId == productId;
      }).firstOrNull;

  if (matchingItem == null) {
    debugPrint('No matching line item found for productId: $productId');
  }
}

DownloadedData? _findMatchingUpper(
  OrderInitialState state,
  int? productId,
  BuildContext context,
) {
  debugPrint('No matching line item found for productId11111: $productId');

  final matchingItem =
      context.read<DownloadPageBloc>().state.orders?.where((item) {
        print("sdlsakd880 ${item}");
        return item.orderId == productId;
      }).firstOrNull;

  if (matchingItem == null) {
    debugPrint('No matching line item found for productId: $productId');
  }
  print("Matching item: ${matchingItem?.toJson()}");
  return matchingItem;
}
