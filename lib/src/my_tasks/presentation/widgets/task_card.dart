import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: const Color(0xFFF5F8FC),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: EdgeInsets.all(16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Assets.task,
              width: 25.w,
              height: 25.h,
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Out Dated Question  ',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '|',
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    ),
                    TextSpan(
                      text: '  This is the content of the question,This is the content of the question...',
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Requested on: 22/04/2025",
                  style: TextStyle(fontSize: 9.sp, color: Colors.grey[600]),
                ),
                SizedBox(height: 8.h),
                OutlinedButton(
                  onPressed: () {
                    // handle navigation
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.purple),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  child: Text(
                    "View",
                    style: TextStyle(
                      color: AppColors.purple,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
