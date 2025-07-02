import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/asset.dart';
import 'package:certempiree/src/my_reward/presentation/widgets/reward_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/res/app_strings.dart';
import '../bloc/report_bloc/get_all_reward_bloc.dart';
import '../bloc/report_bloc/get_all_reward_events.dart';

class WithdrawRequestDialog extends StatelessWidget {
  const WithdrawRequestDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double dialogWidth = screenWidth > 600 ? 400 : screenWidth * 0.7;
    final double dialogHeight = screenHeight > 800 ? 430 : screenHeight * 0.55;

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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.withDrawIcon,
                      color: AppColors.purple,
                      height: 70,
                      width: 70,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Withdraw Request',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'You\'re about to request a withdrawal of \$30 against community help that you rendered wrt Amazon AZ-900. This will be processed manually via a refund.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    RewardButton(
                      onPressed: () async {
                        context.read<MyRewardBloc>().add(
                          WithDrawRewardEvent(
                            context: context,
                            fileId: AppStrings.fileId,
                            userId: AppStrings.userId,
                          ),
                        );
                      },
                      txt: "Continue",
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        context.read<MyRewardBloc>().add(
                          GetCouponEvent(
                            context: context,
                            userId: AppStrings.userId,
                            fileId: AppStrings.fileId,
                          ),
                        );
                      },
                      child: const Text(
                        'Give me equivalent coupon instead',
                        style: TextStyle(
                          fontSize: 13,
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
                child: const Icon(Icons.close, size: 24, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
