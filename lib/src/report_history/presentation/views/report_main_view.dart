import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportMainView extends StatelessWidget {
  const ReportMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
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
                Expanded(
                  child: Text(
                    "Exam Name",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "Status",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Divider(color: AppColors.blue),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      reportRow(
                        reportName: "Outdated Question 05",
                        examName:
                            "AWS Certified Advanced Networking - Specialty ANS-C01",
                        status: "Approved",

                      ),
                      SizedBox(height: 10.h,)
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reportRow({String? reportName, String? examName, String? status}) {
    return Container(
      padding: EdgeInsets.all(10),
      color: AppColors.lightGrey,
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtil().screenWidth * 0.25,
            child: Text(
              reportName ?? "",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              examName ?? "",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            status ?? "",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
