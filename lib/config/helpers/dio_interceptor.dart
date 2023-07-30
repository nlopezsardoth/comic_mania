import 'dart:developer';

import 'package:dio/dio.dart';

class CustomLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('[DioInterceptor]: Request: ${options.method} ${options.uri}');
    log('[DioInterceptor]: Headers: ${options.headers}');
    log('[DioInterceptor]: Body: ${options.data}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('[DioInterceptor]: Response: ${response.statusCode}');
    log('[DioInterceptor]: Body: ${response.data}');
    log('[DioInterceptor]: Headers: ${response.headers}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('[DioInterceptor]: Error: ${err.message}');
    log('[DioInterceptor]: Response: ${err.response?.data}');

    super.onError(err, handler);
  }
}
