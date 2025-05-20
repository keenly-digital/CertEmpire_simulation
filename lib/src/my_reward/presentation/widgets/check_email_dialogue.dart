import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/src/my_reward/presentation/widgets/reward_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/res/asset.dart';

class CheckEmailDialogue extends StatelessWidget {
  const CheckEmailDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double dialogWidth = screenWidth > 600 ? 400 : screenWidth * 0.85;
    final double dialogHeight = screenHeight > 700 ? 300 : screenHeight * 0.55;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.purple, width: 2),
      ),
      child: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(Assets.checkEmail, height: 70, width: 70),
                    const SizedBox(height: 12),
                    const Text(
                      'Check Your Email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'A coupon will be sent to you shortly via email.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    RewardButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      txt: "Close",
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
