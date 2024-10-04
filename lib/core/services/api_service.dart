import 'package:dio/dio.dart';
import 'package:fitwiz/core/interceptors/error_interceptor.dart';
import 'package:fitwiz/core/interceptors/token_interceptor.dart';
import 'package:fitwiz/data/string_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: StringConstants.BASE_URL,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  final TokenInterceptor _tokenInterceptor;
  final ErrorInterceptor _errorInterceptor;

  ApiService(this._tokenInterceptor, [ErrorInterceptor? errorInterceptor])
      : _errorInterceptor = errorInterceptor ?? ErrorInterceptor() {
    _dio.interceptors.add(_tokenInterceptor);
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      enabled: kDebugMode,
    ));
    _dio.interceptors.add(_errorInterceptor);
  }

  Future<Response> get(String url, {Map<String, dynamic>? queryParams}) async {
    final response = await _dio.get(url, queryParameters: queryParams);
    return response;
  }

  Future<Response> post(String url, {Object? data}) async {
    final response = await _dio.post(url, data: data);
    return response;
  }

  Future<Response> put(String url, {Object? data}) async {
    final response = await _dio.put(url, data: data);
    return response;
  }
}
