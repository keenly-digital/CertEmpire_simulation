abstract class RewardInitEvent {}

class GetRewardsEvent extends RewardInitEvent {
  String userId;

  GetRewardsEvent({required this.userId});
}
