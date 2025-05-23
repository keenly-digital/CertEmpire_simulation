import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/report_history/data/models/get_all_reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../report_history_dependencies.dart';
import '../bloc/report_bloc/get_all_report_bloc.dart';
import '../bloc/report_bloc/get_all_report_events.dart';
import '../bloc/report_bloc/get_all_report_state.dart';
import '../widgets/view_reason_dialogue.dart';

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
            final reports = state.reportData ?? [];
            return (state.reportData?.isEmpty ??
                    false || state.reportData == null)
                ? Center(
                  child: Text(
                    "No Report Found",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: ScreenUtil().screenWidth * 0.25,
                            child: Text(
                              "Report Name",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().screenWidth * 0.50,
                            child: Text(
                              "Exam Name",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().screenWidth * 0.20,
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
                                "Showing $pageNumber to ${reports.length} ${state.results ?? 0} results",
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
                                      // Set a fixed width
                                      height: 60,
                                      // Set a fixed height
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(color: Colors.black),
                                      ),
                                      alignment: Alignment.center,
                                      // Centers the child inside
                                      child: Icon(Icons.arrow_back,size: 20,),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        pageNumber++;
                                      });
                                      fetchReports();
                                    },
                                    icon: Container(
                                      width: 30,
                                      // Set a fixed width
                                      height: 60,
                                      // Set a fixed height
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(color: Colors.black),
                                      ),
                                      alignment: Alignment.center,
                                      // Centers the child inside
                                      child: Icon(Icons.arrow_forward,size: 20,),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: ScreenUtil().screenWidth * 0.20,
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
            child: Text(
              examName,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().screenWidth * 0.15,
            child: Row(
              children: [
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: viewReason,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: TextButton(
              onPressed: () {
                context.read<GetAllReportsBloc>().add(
                  GetReasonEvent(reportId: report.id ?? ""),
                );
                showDialog(
                  context: context,
                  builder: (_) => ViewReasonDialog(reportData: report),
                );
              },
              child: Text(
                "View Reason",
                style: TextStyle(
                  fontSize: 8.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
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
