import 'package:certempiree/core/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThankYouDialogue extends StatefulWidget {
  const ThankYouDialogue({super.key});

  @override
  _ThankYouDialogueState createState() => _ThankYouDialogueState();
}

class _ThankYouDialogueState extends State<ThankYouDialogue> {
  @override
  Widget build(BuildContext context) {
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
                  AppStrings.submissionComplete,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  AppStrings.thankYou,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'We will keep you posted.',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
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
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppStrings.close,
                      style: TextStyle(fontSize: 14.sp),
                    ),
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
