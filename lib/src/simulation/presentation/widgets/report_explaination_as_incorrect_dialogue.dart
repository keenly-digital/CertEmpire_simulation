import 'package:certempiree/core/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportExplainationDialogue extends StatelessWidget {
  const ReportExplainationDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.red, width: 1.5.w),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: SizedBox(
        width: ScreenUtil().screenWidth * 0.6,
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.reportExplanation,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red, // underline color

                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  AppStrings.explanationBelow,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    expands: true,
                    style: TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(3.w),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red, width: 1.5.w),
                      foregroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(AppStrings.submit, style: TextStyle(fontSize: 14.sp)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
