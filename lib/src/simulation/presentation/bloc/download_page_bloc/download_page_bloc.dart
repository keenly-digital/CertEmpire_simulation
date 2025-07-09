import 'dart:async';
import 'dart:html' as html;

import 'package:bloc/bloc.dart';
import 'package:certempiree/core/utils/log_util.dart';
import 'package:certempiree/src/simulation/data/models/urls_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
          'consumer_key': AppStrings.consumerKey,
          'consumer_secret': AppStrings.consumerSecret,
        },
      );

      if (response.statusCode == 200) {
        final downloads = DownloadModel.fromJson(response.data);
        // emit(state.copyWith(orders: downloads.data, loading: false));

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
    final url = '${AppStrings.netbaseUrl}WordpressAPI/GetSimulationURL';

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

      for (final fileData in urlsModel.data ?? []) {
        final matchedItem = event.download.firstWhere(
          (element) => element.fileUrl == fileData.fileUrl,
          orElse: () => DownloadedData(),
        );
        matchedItem.fileId = fileData.fileId;
      }

      emit(state.copyWith(orders: event.download, loading: false));
      print(event.download.length);
      event.download.forEach((element) {
        LogUtil.debug(
          "Matched fileId: ${element.fileId} :: fileUrl: ${element.fileUrl}",
        );
      });
    } catch (e) {
      debugPrint('File URL fetch error: $e');
    }
  }

  /// Triggers file export request and opens the resulting PDF link.
  final Dio _dio = Dio();

  /// Triggers the download workflow. Shows loader, makes API call, starts download, handles errors.
  Future<void> exportAndDownloadFile({
    required BuildContext context,
    required String fileId,
    required String type, // 'pdf' or 'qzs'
  }) async {
    _showLoader(context);

    final url = '${AppStrings.netbaseUrl}Quiz/ExportFile';

    try {
      final response = await _dio.get(
        url,
        queryParameters: {'fileId': fileId, 'type': type},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.data['Success'] == true) {
        final downloadUrl = response.data['Data'] as String;
        final filename = _extractFilenameFromUrl(downloadUrl);

        _hideLoader(context);

        await _downloadFile(downloadUrl, filename);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Download started: $filename')));
      } else {
        _hideLoader(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.data['Message'] ?? "Download failed"),
          ),
        );
      }
    } catch (e) {
      _hideLoader(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  static String _extractFilenameFromUrl(String url) {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments;
    if (segments.isNotEmpty) {
      return segments.last;
    }
    return 'downloaded_file';
  }

  /// Downloads the file in browser (web only)
  static Future<void> _downloadFile(String url, String filename) async {
    final anchor =
        html.AnchorElement(href: url)
          ..download = filename
          ..style.display = 'none';
    html.document.body!.append(anchor);
    anchor.click();
    anchor.remove();
  }

  /// Shows modal loader
  static void _showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  /// Hides modal loader
  static void _hideLoader(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
