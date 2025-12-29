import 'package:dio/dio.dart';
import 'package:myvegiz_flutter/src/core/api/api_url.dart';
import '../utils/logger.dart';

/// Custom Dio interceptor to handle API base URL setup

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = ApiUrl.baseUrl;
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(err.response?.statusCode);
    super.onError(err, handler);
  }
}