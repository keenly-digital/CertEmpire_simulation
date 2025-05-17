import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/my_reward/presentation/bloc/report_bloc/get_all_reward_bloc.dart';
import 'package:certempiree/src/my_reward/presentation/widgets/withdraw_request_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../data/models/get_all_reward_data_model.dart';
import '../bloc/report_bloc/get_all_reward_events.dart';
import '../bloc/report_bloc/get_all_reward_state.dart';

class ReportSummaryCard extends StatelessWidget {
  final RewardData? rewardData;
   int index = -1;

   ReportSummaryCard({super.key, this.rewardData,  required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF9FF),
        border: Border.all(color: Colors.purple.shade100),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Number #40235',
                  style: TextStyle(
                    color: AppColors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  rewardData?.fileName ?? "",
                  style: TextStyle(fontSize: 10.sp, color: Colors.black87),
                ),
                SizedBox(height: 14.h),
                Wrap(
                  spacing: 5.w,
                  runSpacing: 5.h,
                  children: [
                    _StatBox(
                      label: 'Reports Submitted',
                      value: "${rewardData?.reportsSubmitted ?? 0}",
                    ),
                    _StatBox(
                      label: 'Reports Approved',
                      value: "${rewardData?.votedReportsApproved ?? 0}",
                    ),
                    _StatBox(
                      label: 'Voted Reports',
                      value: "${rewardData?.votedReports ?? 0}",
                    ),
                    _StatBox(
                      label: 'Voted Reports Approved',
                      value: "${rewardData?.votedReportsApproved ?? 0}",
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100.h, // Adjust height as needed
            child: VerticalDivider(
              width: 20, // spacing around the divider
              thickness: 1.2,
              color: AppColors.dividerColor,
            ),
          ),
          // Right section: Balance and button
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Current Balance',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${rewardData?.filePrice} USD',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              BlocBuilder<MyRewardBloc, RewardInitialState>(
                builder: (context, state) {
                  return (state.withDrawLoading == false &&
                          index == context.read<MyRewardBloc>().cardIndex)
                      ?
                       CircularProgressIndicator():OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.purple,
                      side: BorderSide(color: AppColors.borderColor),
                    ),
                    onPressed: () async {
                      await showDialog<String>(
                        context: context,
                        builder: (context) => const WithdrawRequestDialog(),
                      );
                    },
                    child: TextButton(
                      onPressed: () {
                        context.read<MyRewardBloc>().add(
                          WithDrawRewardEvent(
                            context: context,
                            fileId: AppStrings.fileId,
                            userId: AppStrings.userId,
                          ),
                        );
                      },
                      child: Text(
                        'Withdraw',
                        style: TextStyle(
                          color: AppColors.borderColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;

  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EEF7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.sp, color: Colors.black87),
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
