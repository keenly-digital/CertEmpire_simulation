import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/res/app_strings.dart';
import '../../../data/models/download_model.dart';

part 'download_page_event.dart';
part 'download_page_state.dart';

class DownloadPageBloc extends Bloc<DownloadPageEvent, DownloadPageInitial> {
  DownloadPageBloc() : super(DownloadPageInitial()) {
    on<GetDownloadsEvent>(getDownloadData);
  }

  Future<void> getDownloadData(
    GetDownloadsEvent event,
    Emitter<DownloadPageInitial> emit,
  ) async {
    final dio = Dio();

    final url =
        '${AppStrings.baseUrl}/wp-json/wc/v3/customers/${AppStrings.id}/downloads';
    final consumerKey = 'ck_f6f8767e67544a97e27d0336f31dcf27c882694a';
    final consumerSecret = 'cs_1b64f61e4cf40ae19ab5284143dd19e77cc79620';

    emit(state.copyWith(loading: true)); // Start loading

    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'consumer_key': consumerKey,
          'consumer_secret': consumerSecret,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        final List<DownloadModel> downloads =
            data.map((json) => DownloadModel.fromJson(json)).toList();

        emit(state.copyWith(orders: downloads, loading: false));

        // await addDownloadedUrl(downloads);
      } else {
        print('Failed with status: ${response.statusCode}');
        emit(state.copyWith(loading: false, orders: null));
      }
    } catch (e) {
      print('Request error: $e');
      emit(state.copyWith(loading: false, orders: null));
    }
  }

  Future<void> addDownloadedUrl(List<DownloadModel> download) async {
    final dio = Dio();

    final url =
        'https://certempirbackend-production.up.railway.app/api/WordpressAPI/GetSimulationURL';
    final List<String> fileURLs = [
      'https://certempirbackend-production.up.railway.app/uploads/QuizFiles/MB-330_Dumps_Export.pdf',
      'https://certempirbackend-production.up.railway.app/uploads/QuizFiles/1Z0-830-Full-File_Export.pdf',
    ];

    try {
      final response = await dio.get(
        url,
        queryParameters: {'userId': AppStrings.userId, 'fileURL': fileURLs},
      );
    } catch (e) {
      print('Request error: $e');
    }
  }
}
