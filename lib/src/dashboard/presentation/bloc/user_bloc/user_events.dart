abstract class UserInitEvent {}

class GetUserEvent extends UserInitEvent {
  int userId;

  GetUserEvent({required this.userId});
}
