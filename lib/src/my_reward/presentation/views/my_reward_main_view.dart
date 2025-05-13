import 'package:flutter/material.dart';

import '../widgets/reward_summary_card.dart';

class MyRewardMainView extends StatelessWidget {
  const MyRewardMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return const ReportSummaryCard();
        },
      ),
    );
  }
}
