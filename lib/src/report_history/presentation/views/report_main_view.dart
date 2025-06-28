import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
import 'package:certempiree/src/report_history/data/models/get_all_reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/report_bloc/get_all_report_bloc.dart';
import '../bloc/report_bloc/get_all_report_events.dart';
import '../bloc/report_bloc/get_all_report_state.dart';
// ... your imports ...

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

  void fetchReports() {
    context.read<GetAllReportsBloc>().add(
      GetAllReportsEvent(
        pageSize: 10,
        userId: AppStrings.userId,
        pageNumber: pageNumber,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900; // Table only for desktop screens
    final isMobileOrTablet = width <= 900;

    double maxWidth = double.infinity;

    return BlocBuilder<GetAllReportsBloc, ReportInitialState>(
      builder: (context, state) {
        if (state is GetAllReportState) {
          final moveNext =
              (state.reportData?.length ?? 0) < (state.results ?? 0);
          final reports = state.reportData ?? [];

          return Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              padding: EdgeInsets.symmetric(
                vertical: isDesktop ? 38.h : 18.h,
                horizontal: isDesktop ? 38.w.clamp(18, 64) : 12.w.clamp(8, 30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Reports",
                    style: TextStyle(
                      fontSize:
                          isDesktop
                              ? 27.sp.clampDouble(20, 32)
                              : 21.sp.clampDouble(16, 26),
                      fontWeight: FontWeight.w800,
                      color: AppColors.themeBlue,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: isDesktop ? 22.h : 14.h),

                  // === TABLE ON DESKTOP ONLY ===
                  if (isDesktop) ...[
                    _ModernTableHeader(),
                    const Divider(
                      height: 0,
                      thickness: 2,
                      color: Color(0xFFDEEDFE),
                    ),
                    ...List.generate(reports.length, (index) {
                      final report = reports[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: _DesktopTableRow(
                          report: report,
                          isOdd: index % 2 == 1,
                          onViewReason:
                              report.status == "Disapprove"
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
                        ),
                      );
                    }),
                  ],

                  // === MOBILE CARD VIEW ON TABLET & MOBILE ===
                  if (isMobileOrTablet)
                    (reports.isEmpty)
                        ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 28.h),
                          child: Center(
                            child: Text(
                              "No reports found.",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14.sp.clampDouble(13, 20),
                              ),
                            ),
                          ),
                        )
                        : Column(
                          children: List.generate(reports.length, (index) {
                            final report = reports[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 7.h),
                              child: _MobileReportCard(
                                report: report,
                                isOdd: index % 2 == 1,
                                onViewReason:
                                    report.status == "Disapprove"
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
                              ),
                            );
                          }),
                        ),
                  SizedBox(height: isDesktop ? 18.h : 12.h),
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
    );
  }
}

// ===== TABLE HEADER =====
class _ModernTableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 18.w),
      color: const Color(0xFFF4F6FB),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "Report Name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.2.sp.clampDouble(13, 22),
                color: AppColors.themeBlue,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Exam Name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.2.sp.clampDouble(13, 22),
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
                fontSize: 16.2.sp.clampDouble(13, 22),
                color: AppColors.themeBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===== DESKTOP TABLE ROW =====
class _DesktopTableRow extends StatelessWidget {
  final ReportData report;
  final bool isOdd;
  final VoidCallback? onViewReason;

  const _DesktopTableRow({
    required this.report,
    required this.isOdd,
    this.onViewReason,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isOdd ? const Color(0xFFF8FAFF) : Colors.white;
    final bool showViewReason =
        report.status == "Disapprove" && onViewReason != null;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          if (isOdd)
            BoxShadow(
              color: const Color(0x066D92F6),
              blurRadius: 10.r,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 18.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Report Name
          Expanded(
            flex: 2,
            child: Tooltip(
              message: report.reportName ?? "",
              waitDuration: Duration(milliseconds: 600),
              child: Text(
                report.reportName ?? "",
                style: TextStyle(
                  fontSize: 15.sp.clampDouble(12, 19),
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          // Exam Name
          Expanded(
            flex: 2,
            child: Tooltip(
              message: report.examName ?? "",
              waitDuration: Duration(milliseconds: 600),
              child: Text(
                report.examName ?? "",
                style: TextStyle(
                  fontSize: 14.2.sp.clampDouble(12, 17),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF253468),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          // Status & View Reason (always side by side)
          Expanded(
            flex: 2,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // If you want to stack them vertically at very low widths, add a stack logic here
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IntrinsicWidth(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color:
                              report.status == "Disapprove"
                                  ? Colors.red[100]
                                  : report.status == "Pending"
                                  ? Colors.yellow[100]
                                  : Colors.green[50],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          report.status ?? "",
                          style: TextStyle(
                            fontSize: 14.sp.clampDouble(10, 16),
                            fontWeight: FontWeight.bold,
                            color:
                                report.status == "Disapprove"
                                    ? Colors.red[700]
                                    : report.status == "Pending"
                                    ? Colors.orange
                                    : Colors.green[800],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    if (showViewReason)
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: AppColors.purple.withOpacity(0.4),
                            ),
                            foregroundColor: AppColors.purple,
                            minimumSize: Size(54, 26.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp.clampDouble(10, 15),
                            ),
                          ),
                          onPressed: onViewReason,
                          child: Text(
                            "View Reason",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ===== MOBILE/TABLET CARD VIEW (STACKED) =====
class _MobileReportCard extends StatelessWidget {
  final ReportData report;
  final bool isOdd;
  final VoidCallback? onViewReason;

  const _MobileReportCard({
    required this.report,
    required this.isOdd,
    this.onViewReason,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isOdd ? const Color(0xFFF8FAFF) : Colors.white;
    final bool showViewReason =
        report.status == "Disapprove" && onViewReason != null;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          if (isOdd)
            BoxShadow(
              color: const Color(0x066D92F6),
              blurRadius: 6.r,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            report.reportName ?? "",
            style: TextStyle(
              fontSize: 14.5.sp.clampDouble(12, 18),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            report.examName ?? "",
            style: TextStyle(
              fontSize: 13.2.sp.clampDouble(11, 16),
              fontWeight: FontWeight.w500,
              color: const Color(0xFF253468),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color:
                      report.status == "Disapprove"
                          ? Colors.red[100]
                          : report.status == "Pending"
                          ? Colors.yellow[100]
                          : Colors.green[50],
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  report.status ?? "",
                  style: TextStyle(
                    fontSize: 11.5.sp.clampDouble(10, 14),
                    fontWeight: FontWeight.bold,
                    color:
                        report.status == "Disapprove"
                            ? Colors.red[700]
                            : report.status == "Pending"
                            ? Colors.orange
                            : Colors.green[800],
                  ),
                ),
              ),
              if (showViewReason)
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppColors.purple.withOpacity(0.4),
                      ),
                      foregroundColor: AppColors.purple,
                      minimumSize: Size(0, 30.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11.5.sp.clampDouble(10, 14),
                      ),
                    ),
                    onPressed: onViewReason,
                    child: Text("View Reason", overflow: TextOverflow.ellipsis),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ===== PAGINATION =====
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
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    return Container(
      height: (isMobile ? 42.h : 56.h).clampDouble(38, 64),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.themeBlue.withOpacity(0.13)),
        borderRadius: BorderRadius.circular(isMobile ? 10.r : 15.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x11007FFF),
            blurRadius: (isMobile ? 4.r : 10.r).clampDouble(2, 14),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: isMobile ? 8.h : 16.h),
      padding: EdgeInsets.symmetric(
        horizontal:
            isMobile
                ? 10.w
                : isTablet
                ? 14.w
                : 22.w,
        vertical: isMobile ? 3.h : 6.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Showing $pageNumber to $shown of $total results",
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
              fontSize: (isMobile ? 12.5.sp : 15.3.sp).clampDouble(11, 20),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: canPrev ? onPrev : null,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: canPrev ? AppColors.themeBlue : Colors.grey,
                  size: (isMobile ? 18.sp : 22.sp).clampDouble(16, 26),
                ),
                tooltip: "Previous",
              ),
              IconButton(
                onPressed: canNext ? onNext : null,
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: canNext ? AppColors.themeBlue : Colors.grey,
                  size: (isMobile ? 18.sp : 22.sp).clampDouble(16, 26),
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

// CLAMP EXTENSION
extension DoubleClamp on num {
  double clampDouble(num lowerLimit, num upperLimit) =>
      this < lowerLimit
          ? lowerLimit.toDouble()
          : (this > upperLimit ? upperLimit.toDouble() : this.toDouble());
}
