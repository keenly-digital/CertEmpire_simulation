import 'package:certempiree/src/my_reward/presentation/widgets/reward_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/res/asset.dart';

class FailedDialogue extends StatelessWidget {
  const FailedDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.red, width: 2),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;

          final dialogWidth = screenWidth * 0.65;
          final dialogHeight = screenHeight * 0.65;

          return SizedBox(
            width: dialogWidth,
            height: dialogHeight,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.error,
                          height: 70,
                          width: 70,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Withdrawal failed',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Your current balance is insufficient for withdrawal, or your withdrawal has already been made.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        RewardButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          txt: "Close",
                          borderColor: Colors.red,
                          txtColor: Colors.red,
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
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
