import 'package:certempiree/core/res/app_strings.dart';
import 'package:dio/dio.dart';

import 'dio_interceptors.dart';

class ApiClient {
  late final Dio _dio;
  String _token = '';

  static const _connectTimeout = Duration(minutes: 15);
  static const _receiveTimeout = Duration(minutes: 15);
  static const _sendTimeout = Duration(minutes: 15);

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppStrings.netbaseUrl,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        sendTimeout: _sendTimeout,
      ),
    );
    _dio.interceptors.addAll([
      // Add interceptors for authentication, error handling, etc.
      AuthInterceptor(this),
      ErrorInterceptor(),
      CustomLoggingInterceptor(),
    ]);
  }

  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  String get token => _token;
  set token(String value) => _token = value;

  Dio get dio => _dio;
}
