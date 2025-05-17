import 'package:flutter/cupertino.dart';

abstract class RewardInitEvent {}

class GetRewardsEvent extends RewardInitEvent {
  String userId;

  GetRewardsEvent({required this.userId});
}

class WithDrawRewardEvent extends RewardInitEvent {
  String userId;
  String fileId;
  BuildContext context;

  WithDrawRewardEvent({
    required this.userId,
    required this.fileId,
    required this.context,
  });
}
