/// @Author: Ehsan
/// @Email: muhammad.ehsan@barq.com.pk
/// @Date: 25/06/2025

import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/font_manager.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/main/presentation/bloc/navigation_cubit.dart';
import 'package:certempiree/src/simulation/presentation/bloc/download_page_bloc/download_page_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../data/models/download_model.dart';
import '../bloc/simulation_bloc/simulation_event.dart';

class DownloadTableView extends StatelessWidget {
  DownloadTableView({super.key, required this.download});

  final List<DownloadedData>? download;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(), // Slightly more horizontal space for 'Total'
        4: FlexColumnWidth(2),
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
                'Product',
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontManager.semiBold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'File',
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontManager.semiBold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Remaining',
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontManager.semiBold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Expires',
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
        ...download!.map(
          (item) => TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${item.productName}',
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontManager.regular,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item.productName ?? "",
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontManager.regular,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item.downloadsRemaining ?? "",
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontManager.regular,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  convertDate(item.accessExpires ?? ""),
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontManager.regular,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 130,
                          maxHeight: 44,
                          minHeight: 44,
                          minWidth: 100,
                        ),
                        child: OutlinedButton(
                          onPressed: () {
                            context.read<DownloadPageBloc>().exportFile(
                              item.fileId ?? "",
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                Colors.white, // Button background color
                            side: BorderSide(
                              color: AppColors.lightPrimary, // Border color
                              width: 1, // Border width
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                4,
                              ), // Rounded corners
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ), // Padding inside the button
                          ),
                          child: Text(
                            "Download",
                            style: context.textTheme.labelMedium?.copyWith(
                              color: AppColors.lightPrimary, // Text color
                              fontWeight: FontManager.bold, // Text weight
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 150,
                          maxHeight: 44,
                          minHeight: 44,
                          minWidth: 150,
                        ),
                        child: OutlinedButton(
                          onPressed: () {
                            if (item.fileId?.isEmpty ??
                                false ||
                                    item.fileId == null ||
                                    item.fileId == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("File ID is not available."),
                                ),
                              );
                              return;
                            }
                            AppStrings.fileId = item.fileId ?? "";
                            context.read<SimulationBloc>().add(
                              FetchSimulationDataEvent(
                                fieldId: item.fileId ?? "",
                                pageNumber: 1,
                              ),
                            );
                            context.read<NavigationCubit>().selectTab(
                              2,
                              subTitle: 1,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                Colors.white, // Button background color
                            side: BorderSide(
                              color: AppColors.lightPrimary, // Border color
                              width: 1, // Border width
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                4,
                              ), // Rounded corners
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ), // Padding inside the button
                          ),
                          child: Text(
                            "Practice Online",
                            style: context.textTheme.labelMedium?.copyWith(
                              color: AppColors.lightPrimary, // Text color
                              fontWeight: FontManager.bold, // Text weight
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
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
      return 'Never';
    }
  }
}
