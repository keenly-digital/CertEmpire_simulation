import 'package:certempiree/src/my_reward/presentation/bloc/report_bloc/get_all_reward_bloc.dart';
import 'package:certempiree/src/my_reward/presentation/widgets/withdraw_request_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../data/models/get_all_reward_data_model.dart';
import '../bloc/report_bloc/get_all_reward_state.dart';
import 'failed_dialogue.dart';

class ReportSummaryCard extends StatelessWidget {
  final RewardData? rewardData;
  final int index;

  const ReportSummaryCard({super.key, this.rewardData, required this.index});

  @override
  Widget build(BuildContext context) {
    // The main card container with your styling.
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF9FF),
        border: Border.all(color: Colors.purple.shade100),
        borderRadius: BorderRadius.circular(12),
      ),
      // LayoutBuilder is the key to making the card responsive.
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Set a breakpoint. If the card's width is less than 600, stack the layout.
          bool isNarrow = constraints.maxWidth < 600;

          if (isNarrow) {
            // --- NARROW LAYOUT (COLUMN) ---
            return _buildNarrowLayout(context);
          } else {
            // --- WIDE LAYOUT (ROW) ---
            return _buildWideLayout(context);
          }
        },
      ),
    );
  }

  /// Builds the layout for wide screens (e.g., tablets, desktops).
  Widget _buildWideLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildOrderDetails(context)),
        SizedBox(
          height: 120, // Give the divider a height to be visible
          child: VerticalDivider(
            width: 24, // Spacing around the divider
            thickness: 1,
            color: Colors.grey.shade200,
          ),
        ),
        // The balance section takes its natural width.
        _buildBalanceSection(context, isNarrow: false),
      ],
    );
  }

  /// Builds the layout for narrow screens (e.g., mobile phones).
  Widget _buildNarrowLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOrderDetails(context),
        Divider(height: 32, color: Colors.grey.shade200, thickness: 1),
        _buildBalanceSection(context, isNarrow: true),
      ],
    );
  }

  /// Reusable widget for the left side (Order Info & Stats).
  Widget _buildOrderDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // Using data from the model instead of hardcoded text
          'Order Number ${rewardData?.orderNumber ?? ''}',
          style: TextStyle(
            color: AppColors.purple,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          rewardData?.fileName?.replaceAll("%", "") ?? "",
          style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
        ),
        const SizedBox(height: 16),
        // The Wrap widget replaces the SingleChildScrollView.
        // It automatically wraps stat boxes to the next line if space is limited.
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _StatBox(
              label: 'Reports Submitted',
              value: "${rewardData?.reportsSubmitted ?? 0}",
            ),
            _StatBox(
              label: 'Reports Approved',
              value: "${rewardData?.reportsApproved ?? 0}",
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
    );
  }

  /// Reusable widget for the right side (Balance & Withdraw Button).
  Widget _buildBalanceSection(BuildContext context, {required bool isNarrow}) {
    return Column(
      // On narrow screens, align everything to the start (left).
      // On wide screens, align everything to the end (right).
      crossAxisAlignment:
          isNarrow ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        const Text(
          'Current Balance',
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 4),
        Text(
          '\$${rewardData?.currentBalance ?? '0.00'} USD',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        // Your existing BlocBuilder logic is preserved here.
        BlocBuilder<MyRewardBloc, RewardInitialState>(
          builder: (context, state) {
            // Simplified the loading check for clarity
            bool isLoading =
                state.withDrawLoading == true &&
                index == context.read<MyRewardBloc>().cardIndex;

            if (isLoading) {
              return const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.purple,
                ),
              );
            }

            return OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.purple,
                side: BorderSide(color: AppColors.borderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: () async {
                await showDialog<String>(
                  context: context,
                  builder:
                      (context) =>
                          (rewardData?.currentBalance ?? 0) <= 0
                              ? const FailedDialogue()
                              : const WithdrawRequestDialog(),
                );
              },
              child: Text(
                'Withdraw',
                style: TextStyle(
                  color: AppColors.borderColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

/// The helper widget for stat boxes, now without ScreenUtil.
class _StatBox extends StatelessWidget {
  final String label;
  final String value;

  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EEF7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
