import 'package:equatable/equatable.dart';

import '../../../models/user_model.dart';

class UserInitialState extends Equatable {
  final UserInfoData? userData;
  final bool? loading;
  final int? itemLength;

  @override
  List<Object?> get props => [userData, loading, itemLength];

  const UserInitialState({this.itemLength = 1, this.loading, this.userData});

  UserInitialState copyWith({
    UserInfoData? userData,
    bool? loading,
    String? errorMessage,
  }) {
    return UserInitialState(
      itemLength: itemLength ?? this.itemLength,
      loading: loading ?? this.loading,
      userData: userData ?? this.userData,
    );
  }
}
