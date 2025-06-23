part of 'download_page_bloc.dart';

@immutable
sealed class DownloadPageEvent {}

class GetDownloadsEvent extends DownloadPageEvent {
  final String userId;
  final int pageSize;
  final int pageNumber;

  GetDownloadsEvent({
    required this.userId,
    required this.pageNumber,
    required this.pageSize,
  });
}
