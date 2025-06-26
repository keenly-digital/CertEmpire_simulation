import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:certempiree/src/simulation/data/models/urls_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/res/app_strings.dart';
import '../../../../order/presentation/models/order_model.dart';
import '../../../data/models/download_model.dart';

part 'download_page_event.dart';
part 'download_page_state.dart';

class DownloadPageBloc extends Bloc<DownloadPageEvent, DownloadPageInitial> {
  OrdersDetails ordersDetails = OrdersDetails();

  DownloadPageBloc() : super(DownloadPageInitial()) {
    on<GetDownloadsEvent>(_getDownloadData);
    on<GetFileURlEvent>(_getFileUrls);
  }

  /// Fetches download data from the WordPress API.
  Future<void> _getDownloadData(
    GetDownloadsEvent event,
    Emitter<DownloadPageInitial> emit,
  ) async {
    final dio = Dio();
    final url =
        '${AppStrings.baseUrl}/wp-json/cwc/v2/downloads?customer=${AppStrings.id}';

    emit(state.copyWith(loading: true));

    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'consumer_key': 'ck_f6f8767e67544a97e27d0336f31dcf27c882694a',
          'consumer_secret': 'cs_1b64f61e4cf40ae19ab5284143dd19e77cc79620',
        },
      );

      if (response.statusCode == 200) {
        final downloads = DownloadModel.fromJson(response.data);
        emit(state.copyWith(orders: downloads.data, loading: false));

        // Trigger fetching simulation file URLs after downloads are loaded
        add(GetFileURlEvent(download: downloads.data ?? []));
      } else {
        emit(state.copyWith(loading: false, orders: null));
      }
    } catch (e) {
      debugPrint('Download data request error: $e');
      emit(state.copyWith(loading: false, orders: null));
    }
  }

  /// Sends the list of file URLs to the backend and receives file IDs.
  Future<void> _getFileUrls(
    GetFileURlEvent event,
    Emitter<DownloadPageInitial> emit,
  ) async {
    final dio = Dio();
    const url =
        'https://certempirbackend-production.up.railway.app/api/WordpressAPI/GetSimulationURL';

    final fileURLs =
        event.download
            .map((e) => e.fileUrl ?? '')
            .where((url) => url.isNotEmpty)
            .toList();

    try {
      final response = await dio.post(
        url,
        data: {'userId': AppStrings.userId, 'fileURL': fileURLs},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final urlsModel = UrlsModel.fromJson(response.data);

      for (int i = 0; i < urlsModel.data!.length; i++) {
        event.download[i].fileId = urlsModel.data![i].fileId;
      }

      emit(state.copyWith(orders: event.download, loading: false));
    } catch (e) {
      debugPrint('File URL fetch error: $e');
    }
  }

  /// Triggers file export request and opens the resulting PDF link.
  Future<void> exportFile(String fileId) async {
    final dio = Dio();
    const url =
        'https://certempirbackend-production.up.railway.app/api/Quiz/ExportFile';

    try {
      final response = await dio.get(
        url,
        queryParameters: {'fileId': fileId, 'type': 'pdf'},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.data['Success'] == true) {
        await _launchURL(response.data['Data']);
      }
    } catch (e) {
      debugPrint('Export file error: $e');
    }
  }

  /// Launches the given URL in the browser.
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }
}
