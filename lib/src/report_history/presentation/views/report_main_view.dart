import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
import 'package:certempiree/src/report_history/data/models/get_all_reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/spacer_utility.dart';
import '../bloc/report_bloc/get_all_report_bloc.dart';
import '../bloc/report_bloc/get_all_report_events.dart';
import '../bloc/report_bloc/get_all_report_state.dart';

class ReportMainView extends StatefulWidget {
  const ReportMainView({super.key});

  @override
  State<ReportMainView> createState() => _ReportMainViewState();
}

class _ReportMainViewState extends State<ReportMainView> {
  int pageNumber = 1;

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllReportsBloc, ReportInitialState>(
      builder: (context, state) {
        if (state is GetAllReportState) {
          final moveNext =
              (state.reportData?.length ?? 0) < (state.results ?? 0);
          final reports = state.reportData ?? [];
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1100),
              padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize:
                    MainAxisSize
                        .min, // Ensure column takes minimum vertical space
                children: [
                  Text(
                    "My Reports",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                      color: AppColors.themeBlue,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 22),
                  // Modern table header - NOW RESPONSIVE
                  _ModernTableHeader(),
                  const Divider(
                    height: 0,
                    thickness: 2,
                    color: Color(0xFFDEEDFE),
                  ),
                  reports.isEmpty
                      ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: Center(
                          child: Text(
                            "No reports found.",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      )
                      : Column(
                        children: List.generate(reports.length, (index) {
                          final report = reports[index];
                          // Table row - NOW RESPONSIVE
                          return _ModernTableRow(
                            report: report,
                            isOdd: index % 2 == 1,
                            onViewReason:
                                report.status == "Unapproved"
                                    ? () {
                                      context.read<GetAllReportsBloc>().add(
                                        GetReasonEvent(
                                          reportId: report.id ?? "",
                                          context: context,
                                          report: report,
                                        ),
                                      );
                                    }
                                    : null,
                          );
                        }),
                      ),
                  if (reports.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    // Pager - NOW RESPONSIVE
                    _ModernPager(
                      pageNumber: pageNumber,
                      total: state.results ?? 0,
                      shown: reports.length,
                      canPrev: pageNumber > 1,
                      canNext: moveNext,
                      onPrev: () {
                        if (pageNumber > 1) {
                          setState(() => pageNumber--);
                          fetchReports();
                        }
                      },
                      onNext: () {
                        if (moveNext) {
                          setState(() => pageNumber++);
                          fetchReports();
                        } else {
                          CommonHelper.showToast(message: "No More Reports");
                        }
                      },
                    ),
                  ],
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.purple),
          );
        }
      },
    );
  }

  void fetchReports() {
    context.read<GetAllReportsBloc>().add(
      GetAllReportsEvent(
        pageSize: 10,
        userId: AppStrings.userId,
        pageNumber: pageNumber,
      ),
    );
  }
}

// --- REFACTORED WIDGET ---
class _ModernTableHeader extends StatelessWidget {
  final _headerStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16.2,
    color: AppColors.themeBlue,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F6FB),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 18),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Use Row layout for wide screens
          if (constraints.maxWidth > 650) {
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text("Report Name", style: _headerStyle),
                ),
                Expanded(
                  flex: 3,
                  child: Text("Exam Name", style: _headerStyle),
                ),
                Expanded(flex: 2, child: Text("Status", style: _headerStyle)),
              ],
            );
          }
          // Use Column layout for narrow screens
          return Text("Report Details", style: _headerStyle);
        },
      ),
    );
  }
}

// --- REFACTORED WIDGET ---
class _ModernTableRow extends StatelessWidget {
  final ReportData report;
  final bool isOdd;
  final VoidCallback? onViewReason;

  const _ModernTableRow({
    required this.report,
    required this.isOdd,
    this.onViewReason,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isOdd ? const Color(0xFFF8FAFF) : Colors.white;
    final bool showViewReason =
        report.status == "Unapproved" && onViewReason != null;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          if (isOdd)
            const BoxShadow(
              color: Color(0x066D92F6),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 18),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Use Row layout for wide screens
          if (constraints.maxWidth > 650) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 2, child: _buildReportName()),
                Expanded(flex: 3, child: _buildExamName()),
                Expanded(flex: 2, child: _buildStatus(showViewReason)),
              ],
            );
          }
          // Use Column layout for narrow screens
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabeledData("Report Name", report.reportName),
              const SizedBox(height: 12),
              _buildLabeledData("Exam Name", report.examName),
              const SizedBox(height: 12),
              _buildLabeledData(
                "Status",
                null,
                child: _buildStatus(showViewReason),
              ),
            ],
          );
        },
      ),
    );
  }

  // Helper for mobile layout
  Widget _buildLabeledData(String label, String? data, {Widget? child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.themeBlue,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        if (child != null) child,
        if (data != null)
          Text(
            data,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF253468),
            ),
          ),
      ],
    );
  }

  Widget _buildReportName() => Text(
    report.reportName ?? "",
    style: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
  );

  Widget _buildExamName() => Text(
    report.examName ?? "",
    style: const TextStyle(
      fontSize: 14.2,
      fontWeight: FontWeight.w500,
      color: Color(0xFF253468),
    ),
  );

  Widget _buildStatus(bool showViewReason) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color:
              report.status == "Unapproved"
                  ? Colors.red[100]
                  : Colors.green[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          report.status ?? "",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color:
                report.status == "Unapproved"
                    ? Colors.red[700]
                    : Colors.green[800],
          ),
        ),
      ),
      const SizedBox(width: 8),
      if (showViewReason)
        InkWell(
          onTap: onViewReason,
          child: Text(
            "View Reason",
            style: TextStyle(
              fontSize: 13,
              color: AppColors.purple,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
    ],
  );
}

// --- REFACTORED WIDGET ---
class _ModernPager extends StatelessWidget {
  final int pageNumber;
  final int total;
  final int shown;
  final bool canPrev;
  final bool canNext;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const _ModernPager({
    required this.pageNumber,
    required this.total,
    required this.shown,
    required this.canPrev,
    required this.canNext,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.themeBlue.withOpacity(0.13)),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11007FFF),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final resultsText = Text(
            "Showing page $pageNumber of $total results",
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
              fontSize: 15.3,
            ),
            textAlign: TextAlign.center,
          );

          final buttons = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: canPrev ? onPrev : null,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: canPrev ? AppColors.themeBlue : Colors.grey,
                ),
                tooltip: "Previous",
              ),
              IconButton(
                onPressed: canNext ? onNext : null,
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: canNext ? AppColors.themeBlue : Colors.grey,
                ),
                tooltip: "Next",
              ),
            ],
          );

          // Use Row layout for wide screens
          if (constraints.maxWidth > 650) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [resultsText, buttons],
            );
          }
          // Use Column layout for narrow screens
          return Column(
            children: [resultsText, const SizedBox(height: 4), buttons],
          );
        },
      ),
    );
  }
}
