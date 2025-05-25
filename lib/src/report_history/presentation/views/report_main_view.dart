import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
import 'package:certempiree/src/report_history/data/models/get_all_reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/spacer_utility.dart';
import '../../report_history_dependencies.dart';
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
    reportHistoryDependency();
    fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetAllReportsBloc, ReportInitialState>(
        builder: (context, state) {
          if (state is GetAllReportState) {
            final moveNext =
                (state.reportData?.length ?? 0) < (state.results ?? 0);
            final reports = state.reportData ?? [];
            return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Report Name",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SpacerUtil.horizontalSmall(),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Exam Name",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SpacerUtil.horizontalSmall(),
                          Expanded(
                            child: Text(
                              "Status",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: AppColors.blue, thickness: 2),
                      Expanded(
                        child: ListView.builder(
                          itemCount: reports.length,
                          itemBuilder: (context, index) {
                            final report = reports[index];
                            return Column(
                              children: [
                                Container(
                                  color: AppColors.lightGrey,
                                  child: reportRow(
                                    reportName: report.reportName ?? "",
                                    examName:
                                        report.examName?.replaceAll("%", "") ??
                                        "",
                                    status: report.status ?? "",
                                    viewReason: report.status == "Unapproved",
                                    // viewReason: index % 2 == 0,
                                    report: report,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 60.h,
                        width: ScreenUtil().screenWidth,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.black),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Showing $pageNumber to ${reports.length} of ${state.results ?? 0} results",
                                style: TextStyle(color: Colors.black),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (pageNumber > 1) {
                                        setState(() {
                                          pageNumber--;
                                        });
                                        fetchReports();
                                      }
                                    },
                                    icon: Container(
                                      width: 30,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(color: Colors.black),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(Icons.arrow_back, size: 20),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed:
                                        moveNext
                                            ? () {
                                              setState(() {
                                                pageNumber++;
                                              });
                                              fetchReports();
                                            }
                                            : () {
                                              CommonHelper.showToast(
                                                message: "No More Reports",
                                              );
                                            },
                                    icon: Container(
                                      width: 30,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          color:
                                              !moveNext
                                                  ? Colors.black45
                                                  : Colors.black,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        size: 20,
                                        color:
                                            !moveNext
                                                ? Colors.black45
                                                : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

  Widget reportRow({
    required String reportName,
    required String examName,
    required String status,
    required bool viewReason,
    required ReportData report,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              reportName,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              examName,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "    $status",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          viewReason
              ? TextButton(
                onPressed: () {
                  context.read<GetAllReportsBloc>().add(
                    GetReasonEvent(
                      reportId: report.id ?? "",
                      context: context,
                      report: report,
                    ),
                  );
                },
                child: Text(
                  "View Reason",
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
              : SizedBox(height: 20),
        ],
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
