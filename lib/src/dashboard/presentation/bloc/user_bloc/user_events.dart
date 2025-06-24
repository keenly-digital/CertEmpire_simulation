abstract class UserInitEvent {}

class GetUserEvent extends UserInitEvent {
  String userId;

  GetUserEvent({required this.userId});
}
