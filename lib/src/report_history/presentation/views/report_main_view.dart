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
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: BlocBuilder<GetAllReportsBloc, ReportInitialState>(
        builder: (context, state) {
          if (state is GetAllReportState) {
            final moveNext =
                (state.reportData?.length ?? 0) < (state.results ?? 0);
            final reports = state.reportData ?? [];
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1100),
                padding: const EdgeInsets.symmetric(
                  vertical: 38,
                  horizontal: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    // Modern table header
                    _ModernTableHeader(),
                    const Divider(
                      height: 0,
                      thickness: 2,
                      color: Color(0xFFDEEDFE),
                    ),
                    Expanded(
                      child:
                          reports.isEmpty
                              ? Center(
                                child: Text(
                                  "No reports found.",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,
                                  ),
                                ),
                              )
                              : ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount: reports.length,
                                separatorBuilder:
                                    (c, i) => const SizedBox(height: 2),
                                itemBuilder: (context, index) {
                                  final report = reports[index];
                                  return _ModernTableRow(
                                    report: report,
                                    isOdd: index % 2 == 1,
                                    onViewReason:
                                        report.status == "Unapproved"
                                            ? () {
                                              context
                                                  .read<GetAllReportsBloc>()
                                                  .add(
                                                    GetReasonEvent(
                                                      reportId: report.id ?? "",
                                                      context: context,
                                                      report: report,
                                                    ),
                                                  );
                                            }
                                            : null,
                                  );
                                },
                              ),
                    ),
                    const SizedBox(height: 18),
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
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.purple),
            );
          }
        },
      ),
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

class _ModernTableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 18),
      color: const Color(0xFFF4F6FB),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "Report Name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.2,
                color: AppColors.themeBlue,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Exam Name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.2,
                color: AppColors.themeBlue,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Status",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.2,
                color: AppColors.themeBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Report Name
          Expanded(
            flex: 2,
            child: Text(
              report.reportName ?? "",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          // Exam Name
          Expanded(
            flex: 3,
            child: Text(
              report.examName ?? "",
              style: const TextStyle(
                fontSize: 14.2,
                fontWeight: FontWeight.w500,
                color: Color(0xFF253468),
              ),
            ),
          ),
          // Status & View Reason
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
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
            ),
          ),
        ],
      ),
    );
  }
}

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
      height: 56,
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
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Showing $pageNumber to $shown of $total results",
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
              fontSize: 15.3,
            ),
          ),
          Row(
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
          ),
        ],
      ),
    );
  }
}
