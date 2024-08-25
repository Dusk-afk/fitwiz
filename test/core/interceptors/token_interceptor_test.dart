// Create mock classes
import 'package:dio/dio.dart';
import 'package:fitwiz/core/interceptors/token_interceptor.dart';
import 'package:fitwiz/core/repositories/token_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTokenRepository extends Mock implements TokenRepository {}

class MockDio extends Mock implements Dio {}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class MockRequestOptions extends Mock implements RequestOptions {}

void main() {
  late MockDio mockDio;
  late TokenInterceptor tokenInterceptor;
  late MockTokenRepository mockTokenRepository;
  late MockRequestInterceptorHandler mockRequestInterceptorHandler;
  late RequestOptions requestOptions;
  late MockRequestOptions mockRequestOptions;

  setUp(() {
    mockDio = MockDio();
    mockTokenRepository = MockTokenRepository();
    tokenInterceptor = TokenInterceptor(mockTokenRepository, mockDio);
    mockRequestInterceptorHandler = MockRequestInterceptorHandler();
    requestOptions = RequestOptions(path: '/test');
    mockRequestOptions = MockRequestOptions();
  });

  group('TokenInterceptor', () {
    test('should add access token to request headers if token is not expired',
        () async {
      when(() => mockTokenRepository.isAccessTokenExpired())
          .thenAnswer((_) async => false);
      when(() => mockTokenRepository.getAccessToken())
          .thenAnswer((_) async => 'valid-access-token');

      await tokenInterceptor.onRequest(
          requestOptions, mockRequestInterceptorHandler);

      assert(requestOptions.headers['Authorization'] ==
          'Bearer valid-access-token');
      verify(() => mockRequestInterceptorHandler.next(requestOptions))
          .called(1);
      verifyNever(() => mockTokenRepository.getRefreshToken());
    });
  });

  test('should refresh token and update access token if token is expired',
      () async {
    when(() => mockTokenRepository.isAccessTokenExpired())
        .thenAnswer((_) async => true);
    when(() => mockTokenRepository.getRefreshToken())
        .thenAnswer((_) async => 'valid-refresh-token');
    when(() => mockTokenRepository.saveAccessToken(any()))
        .thenAnswer((_) async {});

    final mockResponse = Response(
      requestOptions: RequestOptions(path: ''),
      data: {'access_token': 'new-access-token'},
      statusCode: 200,
    );
    when(() => mockDio.post(
          '/auth/refresh',
          options: any(named: 'options'),
        )).thenAnswer((_) async => mockResponse);

    when(() => mockTokenRepository.getAccessToken())
        .thenAnswer((_) async => 'new-access-token');

    await tokenInterceptor.onRequest(
        requestOptions, mockRequestInterceptorHandler);

    verify(() => mockTokenRepository.saveAccessToken('new-access-token'))
        .called(1);
    verify(() => mockTokenRepository.getAccessToken()).called(1);
    verify(() => mockRequestInterceptorHandler.next(requestOptions)).called(1);
  });

  test('should skip adding token to request if the route is blacklisted',
      () async {
    when(() => mockRequestOptions.path).thenReturn('/auth/login');

    await tokenInterceptor.onRequest(
        mockRequestOptions, mockRequestInterceptorHandler);

    verify(() => mockRequestInterceptorHandler.next(mockRequestOptions))
        .called(1);
  });

  test('should clear tokens if refresh fails due to unauthorized', () async {
    when(() => mockTokenRepository.isAccessTokenExpired())
        .thenAnswer((_) async => true);
    when(() => mockTokenRepository.getRefreshToken())
        .thenAnswer((_) async => 'valid-refresh-token');

    when(() => mockDio.post(
          '/auth/refresh',
          options: any(named: 'options'),
        )).thenThrow(
      DioException(
        response:
            Response(statusCode: 401, requestOptions: RequestOptions(path: '')),
        requestOptions: RequestOptions(path: ''),
      ),
    );

    when(() => mockTokenRepository.clearTokens()).thenAnswer((_) async {});

    try {
      // Act
      await tokenInterceptor.onRequest(
          requestOptions, mockRequestInterceptorHandler);
      fail('Expected Unauthorized exception');
    } catch (e) {
      // Assert
      expect(e.toString(), contains('Unauthorized'));
    }

    verify(() => mockTokenRepository.clearTokens()).called(1);
  });
}
