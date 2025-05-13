import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/src/my_reward/presentation/widgets/check_email_dialogue.dart';
import 'package:certempiree/src/my_reward/presentation/widgets/reward_button.dart';
import 'package:certempiree/src/my_reward/presentation/widgets/success_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WithdrawRequestDialog extends StatelessWidget {
  const WithdrawRequestDialog({super.key});

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
                    Icon(Icons.wallet, size: 70.r, color: AppColors.purple),
                    Text(
                      'Withdraw Request',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'You\'re about to request a withdrawal of \$30 against community help that you rendered wrt Amazon AZ-900. This will be processed manually via a refund.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 8.sp, color: Colors.black,fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10.h),
                    RewardButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await showDialog<String>(
                          context: context,
                          builder: (context) => const SuccessDialogue(),
                        );
                      },
                      txt: "Continue",
                    ),
                    SizedBox(height: 8.h),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context, 'coupon');
                        await showDialog<String>(
                        context: context,
                        builder: (context) => const CheckEmailDialogue(),
                        );
                      },
                      child: Text(
                        'Give me equivalent coupon instead',
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
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
