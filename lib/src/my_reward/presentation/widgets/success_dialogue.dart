import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/src/my_reward/presentation/widgets/reward_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/res/asset.dart';

class SuccessDialogue extends StatelessWidget {
  const SuccessDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double dialogWidth = screenWidth > 600 ? 380 : screenWidth * 0.85;
    final double dialogHeight = screenHeight > 700 ? 380 : screenHeight * 0.55;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.greenBorder, width: 2),
      ),
      child: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(Assets.sendEmail, height: 70, width: 70),
                    const SizedBox(height: 12),
                    const Text(
                      'Successfully Sent',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Your refund request has been successfully submitted. You will be notified within 1 to 2 working days.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    RewardButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      txtColor: AppColors.greenBorder,
                      txt: "Close",
                      borderColor: AppColors.greenBorder,
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
                child: const Icon(Icons.close, size: 24, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
