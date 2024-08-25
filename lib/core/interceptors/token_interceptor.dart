import 'package:dio/dio.dart';
import 'package:fitwiz/core/repositories/token_repository.dart';
import 'package:fitwiz/data/string_constants.dart';

class TokenInterceptor extends QueuedInterceptor {
  final TokenRepository _tokenRepository;
  final Dio _refreshDio;

  TokenInterceptor(this._tokenRepository, [Dio? refreshDio])
      : _refreshDio = refreshDio ??
            Dio(
              BaseOptions(
                baseUrl: StringConstants.BASE_URL,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 30),
              ),
            );

  final List<String> blackListedRoutes = [
    '/auth/login',
    '/auth/register',
  ];

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (blackListedRoutes.any((route) => options.path.contains(route))) {
      handler.next(options);
      return;
    }

    if (await _tokenRepository.isAccessTokenExpired()) {
      await _refreshToken();
    }

    final accessToken = await _tokenRepository.getAccessToken();
    options.headers['Authorization'] = 'Bearer $accessToken';

    handler.next(options);
  }

  Future<void> _refreshToken() async {
    final refreshToken = await _tokenRepository.getRefreshToken();
    try {
      final response = await _refreshDio.post(
        '/auth/refresh',
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
          },
        ),
      );

      await _tokenRepository.saveAccessToken(response.data['access_token']);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _tokenRepository.clearTokens();
        throw "Unauthorized";
      }
    }
  }
}
