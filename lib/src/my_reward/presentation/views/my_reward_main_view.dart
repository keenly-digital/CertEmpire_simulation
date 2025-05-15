import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/my_reward/presentation/bloc/report_bloc/get_all_reward_bloc.dart';
import 'package:certempiree/src/my_reward/presentation/bloc/report_bloc/get_all_reward_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../reward_dependency_injection.dart';
import '../bloc/report_bloc/get_all_reward_events.dart';
import '../widgets/reward_summary_card.dart';

class MyRewardMainView extends StatefulWidget {
  const MyRewardMainView({super.key});

  @override
  State<MyRewardMainView> createState() => _MyRewardMainViewState();
}

class _MyRewardMainViewState extends State<MyRewardMainView> {
  @override
  void initState() {
    super.initState();
    rewardDependency();

    context.read<MyRewardBloc>().add(
      GetRewardsEvent(userId: AppStrings.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyRewardBloc, RewardInitialState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.rewardData?.length,
            itemBuilder: (context, index) {
              return ReportSummaryCard(rewardData: state.rewardData?[index]);
            },
          );
        },
      ),
    );
  }
}
