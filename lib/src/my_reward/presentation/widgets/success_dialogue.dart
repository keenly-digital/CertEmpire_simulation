import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/src/my_reward/presentation/widgets/reward_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessDialogue extends StatelessWidget {
  const SuccessDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: AppColors.greenBorder, width: 2),
      ),
      child: SizedBox(
        width: 0.75.sw,
        height: 0.65.sh,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.mark_email_read_outlined, size: 70.r, color: AppColors.greenBorder),
                    Text(
                      'Successfully Sent',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Your refund request has been successfully submitted. You will be notified within 1 to 2 working days.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 8.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    RewardButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      txtColor: AppColors.greenBorder,
                      txt: "Close",
                      borderColor: AppColors.greenBorder,
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ),

            // Close button
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close, size: 20.r, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
