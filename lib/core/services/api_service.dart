import 'package:dio/dio.dart';
import 'package:fitwiz/core/interceptors/token_interceptor.dart';
import 'package:fitwiz/data/string_constants.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: StringConstants.BASE_URL,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  final TokenInterceptor _tokenInterceptor;

  ApiService(this._tokenInterceptor) {
    _dio.interceptors.add(_tokenInterceptor);
  }
}
