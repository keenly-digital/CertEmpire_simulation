import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/my_reward/presentation/bloc/report_bloc/get_all_reward_bloc.dart';
import 'package:certempiree/src/my_reward/presentation/bloc/report_bloc/get_all_reward_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../reward_dependency_injection.dart';
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
    rewardDependency();
    fetchReward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyRewardBloc, RewardInitialState>(
        builder: (context, state) {
          return state.loading == true
              ? Center(
                child: CircularProgressIndicator(color: AppColors.purple),
              )
              : (state.rewardData?.isEmpty ?? false)
              ? Center(
                child: Text(
                  "No Reward Found",
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      style: TextStyle(fontWeight: FontWeight.w500),
                      "My Rewards module is based on the rewards that you have earned by helping our community. Please note that you can send only one withdrawal request per order. Therefore, only apply for withdrawal when you believe that you cannot earn  more credits. Please remember that withdrawal credits cannot exceed the initial order amount as the withdrawal are issued in the form of refunds.",
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.rewardData?.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReportSummaryCard(
                                rewardData: state.rewardData?[index],
                                index: index,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 60.h,
                      width: ScreenUtil().screenWidth,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Showing $pageNumber to ${state.rewardData?.length} of ${state.itemLength}",
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (pageNumber > 1) {
                                      setState(() {
                                        pageNumber--;
                                      });
                                      fetchReward();
                                    }
                                  },
                                  icon: Container(
                                    width: 30,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(Icons.arrow_back, size: 20),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      pageNumber++;
                                    });
                                    fetchReward();
                                  },
                                  icon: Container(
                                    width: 30,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(Icons.arrow_forward, size: 20),
                                  ),
                                ),
                              ],
                            ),
                          ],
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

  void fetchReward() {
    context.read<MyRewardBloc>().add(
      GetRewardsEvent(
        userId: AppStrings.userId,
        pageNumber: pageNumber,
        pageSize: 10,
      ),
    );
  }
}
