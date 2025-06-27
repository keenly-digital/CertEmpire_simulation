import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/my_reward/presentation/bloc/report_bloc/get_all_reward_bloc.dart';
import 'package:certempiree/src/my_reward/presentation/bloc/report_bloc/get_all_reward_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/shared/widgets/toast.dart';
import '../bloc/report_bloc/get_all_reward_events.dart';
import '../widgets/reward_summary_card.dart';

class MyRewardMainView extends StatefulWidget {
  const MyRewardMainView({super.key});

  @override
  State<MyRewardMainView> createState() => _MyRewardMainViewState();
}

class _MyRewardMainViewState extends State<MyRewardMainView> {
  int pageNumber = 1;

  @override
  void initState() {
    super.initState();
    fetchReward();
  }

  void fetchReward() {
    context.read<MyRewardBloc>().add(
      GetRewardsEvent(
        userId: AppStrings.userId,
        pageNumber: pageNumber,
        pageSize: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyRewardBloc, RewardInitialState>(
      builder: (context, state) {
        final moveNext =
            (state.rewardData?.length ?? 0) < (state.itemLength ?? 0);

        if (state.loading == true) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.purple),
          );
        }
        if ((state.rewardData?.isEmpty ?? true)) {
          return Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 38),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x11006fff),
                    blurRadius: 18,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.redeem, color: AppColors.themeBlue, size: 54),
                  const SizedBox(height: 18),
                  Text(
                    "No Reward Found",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        // Rewards exist
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 26),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: const Color(0xFFF6F8FE),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Text(
                    "My Rewards module is based on the rewards that you have earned by helping our community.\n"
                    "You can send only one withdrawal request per order. Only apply for withdrawal when you believe that you cannot earn more credits. "
                    "Withdrawal credits cannot exceed the initial order amount as the withdrawals are issued in the form of refunds.",
                    style: TextStyle(
                      color: AppColors.themeBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.5,
                      height: 1.54,
                      letterSpacing: 0.09,
                    ),
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.rewardData?.length ?? 0,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.zero,
                    color: Colors.white,
                    elevation: 3,
                    shadowColor: AppColors.themeBlue.withOpacity(0.09),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(
                        color: AppColors.themeBlue.withOpacity(0.08),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 22,
                      ),
                      child: ReportSummaryCard(
                        rewardData: state.rewardData?[index],
                        index: index,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 22),
              _ModernPager(
                pageNumber: pageNumber,
                shown: state.rewardData?.length ?? 0,
                total: state.itemLength ?? 0,
                canPrev: pageNumber > 1,
                canNext: moveNext,
                onPrev: () {
                  if (pageNumber > 1) {
                    setState(() => pageNumber--);
                    fetchReward();
                  }
                },
                onNext: () {
                  if (moveNext) {
                    setState(() => pageNumber++);
                    fetchReward();
                  } else {
                    CommonHelper.showToast(message: "No More Reward");
                  }
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

class _ModernPager extends StatelessWidget {
  final int pageNumber;
  final int shown;
  final int total;
  final bool canPrev;
  final bool canNext;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const _ModernPager({
    required this.pageNumber,
    required this.shown,
    required this.total,
    required this.canPrev,
    required this.canNext,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.themeBlue.withOpacity(0.13)),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0f006fff),
            blurRadius: 9,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Showing $pageNumber to $shown of $total results",
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
              fontSize: 15.2,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: canPrev ? onPrev : null,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: canPrev ? AppColors.themeBlue : Colors.grey,
                ),
                tooltip: "Previous",
              ),
              IconButton(
                onPressed: canNext ? onNext : null,
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: canNext ? AppColors.themeBlue : Colors.grey,
                ),
                tooltip: "Next",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
