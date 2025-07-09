import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/models/more_option_item.dart';

class NavigationCubit extends Cubit<NavigationCubitState> {
  NavigationCubit() : super(NavigationCubitState());

  void selectTab(int index, {int subTitle = 0}) {
    emit(
      state.copyWith(
        index: index,
        viewType: MobileMoreOptionViewType.primary,
        subTitleIndex: subTitle,
      ),
    );
  }
}

class NavigationCubitState extends Equatable {
  final MobileMoreOptionViewType viewType;
  final int index;
  final int subTitleIndex;

  const NavigationCubitState({
    this.viewType = MobileMoreOptionViewType.primary,
    this.index = 0,
    this.subTitleIndex = 0,
  });

  NavigationCubitState copyWith({
    int? index,
    MobileMoreOptionViewType? viewType,
    int? subTitleIndex,
  }) {
    return NavigationCubitState(
      index: index ?? this.index,
      viewType: viewType ?? this.viewType,
      subTitleIndex: subTitleIndex ?? this.subTitleIndex,
    );
  }

  @override
  List<Object?> get props => [index, viewType, subTitleIndex];
}
