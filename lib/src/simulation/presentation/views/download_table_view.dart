import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/font_manager.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/main/presentation/bloc/navigation_cubit.dart';
import 'package:certempiree/src/simulation/presentation/bloc/download_page_bloc/download_page_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../data/models/download_model.dart'; // Make sure this import points to your actual model
import '../bloc/simulation_bloc/simulation_event.dart';

class DownloadTableView extends StatelessWidget {
  final List<DownloadedData>? download;
  const DownloadTableView({super.key, required this.download});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      margin: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 16),
      color: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Downloads",
              style: context.textTheme.titleLarge?.copyWith(
                color: AppColors.themeBlue,
                fontWeight: FontManager.bold,
                letterSpacing: 0.1,
              ),
            ),
            const SizedBox(height: 22),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 800) {
                  // Breakpoint for switching to list view
                  return _buildListView(context);
                } else {
                  // Pass constraints to the flexible table
                  return _buildFlexibleDataTable(context, constraints);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Pass BoxConstraints down to make intelligent layout decisions
  Widget _buildFlexibleDataTable(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    final headingStyle = context.textTheme.labelLarge?.copyWith(
      color: AppColors.themeBlue,
      fontWeight: FontManager.bold,
      fontSize: 15.5,
    );

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6FB),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              // *** FLEX VALUES ADJUSTED HERE ***
              Expanded(
                flex: 5,
                child: Text('Product', style: headingStyle),
              ), // Increased
              Expanded(flex: 3, child: Text('File', style: headingStyle)),
              Expanded(flex: 2, child: Text('Remaining', style: headingStyle)),
              Expanded(flex: 3, child: Text('Expires', style: headingStyle)),
              Expanded(
                flex: 4,
                child: Text('Actions', style: headingStyle),
              ), // Increased
            ],
          ),
        ),
        const Divider(),
        if (download?.isNotEmpty == true)
          ...download!.map(
            (item) => _buildFlexibleDataRow(context, item, constraints),
          )
        else
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text('No downloads available'),
          ),
      ],
    );
  }

  // Pass BoxConstraints down to the row
  Widget _buildFlexibleDataRow(
    BuildContext context,
    DownloadedData item,
    BoxConstraints constraints,
  ) {
    final cellTextStyle = context.textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Vertically center align content
            children: [
              // *** FLEX VALUES ADJUSTED HERE TO MATCH HEADER ***
              Expanded(
                flex: 5,
                child: Text(
                  item.productName ?? "",
                  style: cellTextStyle?.copyWith(
                    fontWeight: FontManager.semiBold,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(item.downloadName ?? "", style: cellTextStyle),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  item.downloadsRemaining ?? "",
                  style: cellTextStyle,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  convertDate(item.accessExpires ?? ""),
                  style: cellTextStyle,
                ),
              ),
              Expanded(
                flex: 4,
                // Pass constraints to the action buttons
                child: _buildActionButtons(context, item, constraints),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    // This is the view for small mobile screens, no changes here.
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: download?.isNotEmpty == true ? download!.length : 1,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        if (download?.isEmpty ?? true) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Center(child: Text('No downloads available')),
          );
        }
        final item = download![index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
          title: Text(
            item.productName ?? 'No Product Name',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontManager.semiBold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text('File: ${item.downloadName ?? "N/A"}'),
              Text('Remaining: ${item.downloadsRemaining ?? "N/A"}'),
              Text('Expires: ${convertDate(item.accessExpires ?? "")}'),
              const SizedBox(height: 12),
              // For the list view, Wrap is always a good choice.
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _getButtonList(context, item),
              ),
            ],
          ),
        );
      },
    );
  }

  // **THE KEY CHANGE IS HERE**
  // This widget now uses the screen constraints to decide its layout.
  Widget _buildActionButtons(
    BuildContext context,
    DownloadedData item,
    BoxConstraints constraints,
  ) {
    // Check if the card's width is above a certain threshold.
    // 950px for the card width roughly corresponds to a ~1200px screen width.
    // This is our breakpoint for stacking vs. not stacking the buttons.
    bool useHorizontalLayout = constraints.maxWidth > 950;

    final buttons = _getButtonList(context, item);

    if (useHorizontalLayout) {
      // On wider screens, force a horizontal layout.
      return Row(children: buttons);
    } else {
      // On narrower screens, allow stacking.
      return Wrap(spacing: 8.0, runSpacing: 8.0, children: buttons);
    }
  }

  // Helper function to avoid duplicating the button list
  List<Widget> _getButtonList(BuildContext context, DownloadedData item) {
    return [
      _DownloadActionBtn(
        label: "Download",
        icon: Icons.download_rounded,
        color: AppColors.themeBlue,
      ),
      const SizedBox(width: 8), // This SizedBox works for both Row and Wrap
      _ModernActionBtn(
        label: "Practice",
        icon: Icons.play_circle_fill_rounded,
        color: Colors.green[700]!,
        onTap: () {
          if (item.fileId?.isEmpty ?? true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("File ID is not available.")),
            );
            return;
          }
          AppStrings.fileId = item.fileId ?? "";
          context.read<SimulationBloc>().add(
            FetchSimulationDataEvent(fieldId: item.fileId ?? "", pageNumber: 1),
          );
          context.go("/Downloads/Simulation");
        },
      ),
    ];
  }

  String convertDate(String isoTimestamp) {
    try {
      final dateTime = DateTime.parse(isoTimestamp);
      return DateFormat('MMMM d, yyyy').format(dateTime);
    } catch (_) {
      return 'Never';
    }
  }
}

class _ModernActionBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _ModernActionBtn({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(icon, size: 18, color: color),
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontManager.bold,
          fontSize: 14.5,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: color.withOpacity(0.09),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: const Size(45, 40),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
      onPressed: onTap,
    );
  }
}

class _DownloadActionBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _DownloadActionBtn({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });

  Future<void> _showLoader(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _hideLoader(BuildContext context) async {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (label == "Download") {
      return PopupMenuButton<String>(
        offset: const Offset(0, 40), // 40 = button height, adjust as needed
        tooltip: label,
        onSelected: (value) async {
          final bloc = context.read<DownloadPageBloc>();
          final fileId = AppStrings.fileId; // Pass fileId as needed!

          // 1. Show loader
          // await _showLoader(context);

          // 2. Call API
          if (value == 'pdf') {
            // await bloc.exportFile(fileId, "pdf");

            await downloadAssetPdf('MB-330_Dumps.pdf', 'MB-330_Dumps.pdf');
          } else if (value == 'qzs') {
            // await bloc.exportFile(fileId, "qzs");

            await downloadAssetPdf('MB-330_Dumps.pdf', 'MB-330_Dumps.pdf');
          }

          // 3. Hide loader
          // _hideLoader(context);

          // 4. If you want: Show toast/snackbar for result or errors!
        },
        itemBuilder:
            (context) => [
              const PopupMenuItem(value: 'pdf', child: Text('Download as PDF')),
              const PopupMenuItem(value: 'qzs', child: Text('Download as QZS')),
            ],
        child: TextButton.icon(
          icon: Icon(icon, size: 18, color: color),
          label: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14.5,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: color.withOpacity(0.09),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: const Size(45, 40),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          ),
          onPressed: null, // Prevent direct press
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
