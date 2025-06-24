part of 'download_page_bloc.dart';

@immutable
class DownloadPageInitial extends Equatable {
  final List<DownloadModel>? orders;
  final bool? loading;
  final int? itemLength;

  @override
  List<Object?> get props => [orders, loading, itemLength];

  const DownloadPageInitial({this.itemLength = 1, this.loading, this.orders});

  DownloadPageInitial copyWith({
    List<DownloadModel>? orders,
    bool? loading,
    int? itemLength,
  }) {
    return DownloadPageInitial(
      itemLength: itemLength ?? this.itemLength,
      loading: loading ?? this.loading,
      orders: orders ?? this.orders,
    );
  }
}
