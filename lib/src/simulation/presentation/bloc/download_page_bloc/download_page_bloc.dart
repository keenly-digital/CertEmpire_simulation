import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'download_page_event.dart';
part 'download_page_state.dart';

class DownloadPageBloc extends Bloc<DownloadPageEvent, DownloadPageState> {
  DownloadPageBloc() : super(DownloadPageInitial()) {
    on<GetDownloadsEvent>((event, emit) {

    });
  }
}
