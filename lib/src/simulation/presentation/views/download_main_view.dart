import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/main/presentation/bloc/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/font_manager.dart';
import '../../data/models/download_model.dart';
import '../bloc/download_page_bloc/download_page_bloc.dart';

class DownloadMainView extends StatefulWidget {
  const DownloadMainView({super.key});

  @override
  State<DownloadMainView> createState() => _DownloadMainViewState();
}

class _DownloadMainViewState extends State<DownloadMainView> {
  @override
  void initState() {
    super.initState();
    context.read<DownloadPageBloc>().add(
      GetDownloadsEvent(pageNumber: 1, pageSize: 10, userId: AppStrings.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            BlocBuilder<DownloadPageBloc, DownloadPageInitial>(
              builder: (context, state) {
                final downloads = state.orders ?? [];
                return DownloadTableView(downloads: downloads);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DownloadTableView extends StatelessWidget {
  final List<DownloadedData> downloads;

  const DownloadTableView({super.key, required this.downloads});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(2),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        // Header
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade50),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 14.0,
              ),
              child: Text(
                'Product',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontManager.semiBold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'File',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontManager.semiBold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Remaining',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontManager.semiBold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Expires',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontManager.semiBold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Actions',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontManager.semiBold,
                ),
              ),
            ),
          ],
        ),
        // Data rows
        ...downloads.map(
          (download) => TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  download.productName ?? "",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontManager.regular,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  download.productName ?? "",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontManager.regular,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  download.downloadsRemaining ?? "",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontManager.regular,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  convertDate(download.accessExpires ?? ""),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontManager.regular,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 4,
                    children: [
                      _DownloadButton(
                        label: "Download",
                        onTap: () async {
                          await launchUrl(
                            Uri.parse(
                              "https://certempirbackend-production.up.railway.app/uploads/QuizFiles/MB-330_Dumps_Export.pdf",
                            ),
                          );
                        },
                      ),
                      _DownloadButton(
                        label: "Practice Online",
                        onTap: () {
                          // Use context.read if needed, just like in your code
                          context.read<NavigationCubit>().selectTab(
                            2,
                            subTitle: 1,
                          );
                        },
                      ),
                    ],
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

class _DownloadButton extends StatelessWidget {
  final String label;
  final void Function()? onTap;

  const _DownloadButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 40,
        maxWidth: 110,
        minHeight: 34,
        maxHeight: 44,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.lightPrimary, // Like Orders' view button
            borderRadius: BorderRadius.circular(1),
          ),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.lightBackgroundpurple,
                fontWeight: FontManager.semiBold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
