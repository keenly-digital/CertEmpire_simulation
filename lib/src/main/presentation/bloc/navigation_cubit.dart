import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/models/more_option_item.dart';

class NavigationCubit extends Cubit<NavigationCubitState> {
  NavigationCubit() : super(NavigationCubitState());

  void selectTab(int index) {
    emit(
      state.copyWith(index: index, viewType: MobileMoreOptionViewType.primary),
    );
  }

  void reset() {
    emit(state.copyWith(index: 0));
  }

  void goToHome() {
    emit(state.copyWith(index: 0, viewType: MobileMoreOptionViewType.primary));
  }

  void goToFiles() {
    emit(state.copyWith(index: 1, viewType: MobileMoreOptionViewType.primary));
  }

  void goToQuiz() {
    emit(state.copyWith(index: 2, viewType: MobileMoreOptionViewType.primary));
  }

  void goToAccount() {
    emit(state.copyWith(index: 3, viewType: MobileMoreOptionViewType.primary));
  }

  void goToUser() {
    emit(state.copyWith(index: 4, viewType: MobileMoreOptionViewType.primary));
  }

  void goToTools() {
    emit(state.copyWith(index: 5, viewType: MobileMoreOptionViewType.primary));
  }

  void updateViewType(MobileMoreOptionViewType viewType) {
    emit(state.copyWith(viewType: viewType));
  }
}

class NavigationCubitState extends Equatable {
  final MobileMoreOptionViewType viewType;
  final int index;

  const NavigationCubitState({
    this.viewType = MobileMoreOptionViewType.primary,
    this.index = 0,
  });

  NavigationCubitState copyWith({
    int? index,
    MobileMoreOptionViewType? viewType,
  }) {
    return NavigationCubitState(
      index: index ?? this.index,
      viewType: viewType ?? this.viewType,
    );
  }

  @override
  List<Object?> get props => [index, viewType];
}
