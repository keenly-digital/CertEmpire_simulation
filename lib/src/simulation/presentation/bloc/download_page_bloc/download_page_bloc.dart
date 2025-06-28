import 'dart:async';
import 'dart:html' as html;

import 'package:bloc/bloc.dart';
import 'package:certempiree/src/simulation/data/models/urls_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

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

  /// Triggers file export request and downloads file with proper name & format.
  Future<void> exportFile(
    String fileId, {
    String format = "pdf",
    bool forceDownload = false,
    String? fileName,
  }) async {
    final dio = Dio();
    const url =
        'https://certempirbackend-production.up.railway.app/api/Quiz/ExportFile';

    // Clean the filename for safety (no spaces, no special chars)
    String safeName = (fileName ?? "download")
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(' ', '_');

    final downloadFileName = "$safeName.$format";

    try {
      final response = await dio.get(
        url,
        queryParameters: {'fileId': fileId, 'type': format},
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        // 1. If backend returns raw bytes (PDF, QZS, etc. directly)
        if (response.data is List<int>) {
          final bytes = response.data as List<int>;
          final blob = html.Blob([bytes]);
          final url2 = html.Url.createObjectUrlFromBlob(blob);
          final anchor =
              html.AnchorElement(href: url2)
                ..setAttribute('download', downloadFileName)
                ..style.display = 'none';
          html.document.body?.append(anchor);
          anchor.click();
          anchor.remove();
          html.Url.revokeObjectUrl(url2);
        }
        // 2. If backend returns a JSON with a file URL as 'Data'
        else if (response.data is Map && response.data['Data'] != null) {
          final fileUrl = response.data['Data'] as String;
          final anchor =
              html.AnchorElement(href: fileUrl)
                ..setAttribute('download', downloadFileName)
                ..style.display = 'none';
          html.document.body?.append(anchor);
          anchor.click();
          anchor.remove();
        }
      }
    } catch (e) {
      debugPrint('Export file error: $e');
    }
  }
}
