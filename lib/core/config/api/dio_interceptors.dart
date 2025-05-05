import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../utils/log_util.dart';
import 'dio_client_config.dart';

class AuthInterceptor extends Interceptor {
  final ApiClient client;

  AuthInterceptor(this.client);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('Setting-Up-Auth-Token = ${client.token}');

    if (client.token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${client.token}';
    }
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    handler.next(options);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('Error: ${err.response?.statusCode} - ${err.message}');
    handler.next(err);
  }
}

class CustomLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LogUtil.info("🚀 Request: [${options.method}] ${options.uri}");
    if (options.headers.isNotEmpty) {
      LogUtil.debug("Headers: ${options.headers}");
    }
    if (options.data != null) {
      LogUtil.debug("Body: ${options.data}");
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    LogUtil.info(
        "✅ Response: [${response.statusCode}] ${response.requestOptions.uri}");
    LogUtil.debug("Response Body: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LogUtil.error(
      "❌ Error: [${err.response?.statusCode ?? 'Unknown'}] ${err.requestOptions.uri}",
      err,
      err.stackTrace,
    );
    if (err.response?.data != null) {
      LogUtil.debug("Error Response Body: ${err.response?.data}");
    }
    super.onError(err, handler);
  }
}
