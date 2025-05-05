
import 'package:dio/dio.dart';

import 'dio_interceptors.dart';

class ApiClient {
  late final Dio _dio;
  String _token = '';
  static const _baseUrl = 'https://exam-backend-production-1314.up.railway.app/api';
  static const _connectTimeout = Duration(minutes: 5);
  static const _receiveTimeout = Duration(minutes: 5);
  static const _sendTimeout = Duration(minutes: 5);

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
    ));
    _dio.interceptors.addAll([
      // Add interceptors for authentication, error handling, etc.
      AuthInterceptor(this),
      ErrorInterceptor(),
      CustomLoggingInterceptor()
    ]);


  }

  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  String get token => _token;
  set token(String value) => _token = value;

  Dio get dio => _dio;
}
