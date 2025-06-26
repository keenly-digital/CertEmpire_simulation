import '../../../models/user_model.dart';

abstract class UserInitEvent {}

class GetUserEvent extends UserInitEvent {
  int userId;

  GetUserEvent({required this.userId});
}

class UpdateUserEvent extends UserInitEvent {
  UserInfoData userInfoData;

  UpdateUserEvent({required this.userInfoData});
}
