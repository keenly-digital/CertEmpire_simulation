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
  final List<DownloadedData>? download;
  DownloadTableView({super.key, required this.download});

  @override
  Widget build(BuildContext context) {
    // We wrap with LayoutBuilder to get parent width for max responsiveness
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
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
                // Table fits full available width now
                SizedBox(
                  width: constraints.maxWidth, // Fill the card width!
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                      const Color(0xFFF4F6FB),
                    ),
                    headingTextStyle: context.textTheme.labelLarge?.copyWith(
                      color: AppColors.themeBlue,
                      fontWeight: FontManager.bold,
                      fontSize: 15.5,
                    ),
                    dataRowMinHeight: 56,
                    dataRowMaxHeight: 62,
                    columns: const [
                      DataColumn(label: Text('Product')),
                      DataColumn(label: Text('File')),
                      DataColumn(label: Text('Remaining')),
                      DataColumn(label: Text('Expires')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows:
                        download?.isNotEmpty == true
                            ? download!
                                .map(
                                  (item) => DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          '${item.productName}',
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                                fontWeight:
                                                    FontManager.semiBold,
                                              ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          item.downloadName ?? "",
                                          style: context.textTheme.bodySmall,
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          item.downloadsRemaining ?? "",
                                          style: context.textTheme.bodySmall,
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          convertDate(item.accessExpires ?? ""),
                                          style: context.textTheme.bodySmall,
                                        ),
                                      ),
                                      DataCell(
                                        Row(
                                          children: [
                                            _ModernActionBtn(
                                              label: "Download",
                                              icon: Icons.download_rounded,
                                              color: AppColors.themeBlue,
                                              onTap: () {
                                                context
                                                    .read<DownloadPageBloc>()
                                                    .exportFile(
                                                      item.fileId ?? "",
                                                    );
                                              },
                                            ),
                                            const SizedBox(width: 8),
                                            _ModernActionBtn(
                                              label: "Practice",
                                              icon:
                                                  Icons
                                                      .play_circle_fill_rounded,
                                              color: Colors.green[700]!,
                                              onTap: () {
                                                if (item.fileId?.isEmpty ??
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
                                                    item.fileId ?? "";
                                                context
                                                    .read<SimulationBloc>()
                                                    .add(
                                                      FetchSimulationDataEvent(
                                                        fieldId:
                                                            item.fileId ?? "",
                                                        pageNumber: 1,
                                                      ),
                                                    );
                                                context
                                                    .read<NavigationCubit>()
                                                    .selectTab(2, subTitle: 1);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList()
                            : [
                              const DataRow(
                                cells: [
                                  DataCell(Text('No downloads available')),
                                  DataCell(Text('-')),
                                  DataCell(Text('-')),
                                  DataCell(Text('-')),
                                  DataCell(Text('-')),
                                ],
                              ),
                            ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
