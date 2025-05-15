import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/src/my_reward/presentation/widgets/reward_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/res/asset.dart';

class CheckEmailDialogue extends StatelessWidget {
  const CheckEmailDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: AppColors.purple, width: 2),
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
                    Image.asset(Assets.checkEmail, height: 70.h, width: 70.w),
                    Text(
                      'Check Your Email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'A Coupon will be sent to you shortly via email.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    RewardButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      txt: "Close",
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
