import 'package:certempiree/src/report_history/data/models/get_all_reports.dart';
import 'package:certempiree/src/report_history/presentation/bloc/report_bloc/get_all_report_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/report_bloc/get_all_report_state.dart';

class ViewReasonDialog extends StatelessWidget {
  final ReportData reportData;

  const ViewReasonDialog({super.key, required this.reportData});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.deepPurple, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "View Reason",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(color: Colors.deepPurple),

            /// Exam Name
            Row(
              children: [
                Text(
                  "Exam Name : ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                Expanded(
                  child: Text(
                    reportData.examName ?? "",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),

            /// Status
            Row(
              children: [
                Text(
                  "Status : ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  reportData.status ?? "",
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),

            SizedBox(height: 16.h),
            Divider(),

            /// Explanation title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Explanation",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
              ),
            ),
            SizedBox(height: 8.h),

            /// Explanation content
            BlocBuilder<GetAllReportsBloc, ReportInitialState>(
              builder: (context, state) {
                if (state is GetAllReportState) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child:
                        state.reasonLoading == true
                            ? Center(child: CircularProgressIndicator())
                            : Text(
                              state.explanation ?? "",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
