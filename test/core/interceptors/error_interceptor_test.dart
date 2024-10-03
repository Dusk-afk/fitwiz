import 'package:dio/dio.dart';
import 'package:fitwiz/core/interceptors/error_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDioException extends Mock implements DioException {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

class MockRequestOptions extends Mock implements RequestOptions {}

class MockResponse extends Mock implements Response {}

void main() {
  late MockDioException mockDioException;
  late MockErrorInterceptorHandler mockErrorInterceptorHandler;
  late ErrorInterceptor errorInterceptor;
  late MockResponse mockResponse;

  setUp(() {
    mockDioException = MockDioException();
    mockErrorInterceptorHandler = MockErrorInterceptorHandler();
    errorInterceptor = ErrorInterceptor();
    mockResponse = MockResponse();

    when(() => mockDioException.requestOptions)
        .thenReturn(MockRequestOptions());
    when(() => mockDioException.response).thenReturn(mockResponse);
  });

  group('ErrorInterceptor', () {
    test('should throw DeadlineExceededException if connection timeout', () {
      when(() => mockDioException.type)
          .thenReturn(DioExceptionType.connectionTimeout);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<DeadlineExceededException>()),
      );
    });

    test('should throw DeadlineExceededException if send timeout', () {
      when(() => mockDioException.type)
          .thenReturn(DioExceptionType.sendTimeout);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<DeadlineExceededException>()),
      );
    });

    test('should throw DeadlineExceededException if receive timeout', () {
      when(() => mockDioException.type)
          .thenReturn(DioExceptionType.receiveTimeout);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<DeadlineExceededException>()),
      );
    });

    test('should throw BadRequestException if status code is 400', () {
      when(() => mockDioException.type)
          .thenReturn(DioExceptionType.badResponse);
      when(() => mockResponse.statusCode).thenReturn(400);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<BadRequestException>()),
      );
    });

    test('should throw UnauthorizedException if status code is 401', () {
      when(() => mockDioException.type)
          .thenReturn(DioExceptionType.badResponse);
      when(() => mockResponse.statusCode).thenReturn(401);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<UnauthorizedException>()),
      );
    });

    test('should throw UnauthorizedException if status code is 403', () {
      when(() => mockDioException.type)
          .thenReturn(DioExceptionType.badResponse);
      when(() => mockResponse.statusCode).thenReturn(403);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<UnauthorizedException>()),
      );
    });

    test('should throw NotFoundException if status code is 404', () {
      when(() => mockDioException.type)
          .thenReturn(DioExceptionType.badResponse);
      when(() => mockResponse.statusCode).thenReturn(404);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('should throw MethodNotAllowedException if status code is 405', () {
      when(() => mockDioException.type)
          .thenReturn(DioExceptionType.badResponse);
      when(() => mockResponse.statusCode).thenReturn(405);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<MethodNotAllowedException>()),
      );
    });

    test('should throw ConflictException if status code is 409', () {
      when(() => mockDioException.type)
          .thenReturn(DioExceptionType.badResponse);
      when(() => mockResponse.statusCode).thenReturn(409);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<ConflictException>()),
      );
    });

    test('should throw ValidationFailedException if status code is 412', () {
      when(() => mockDioException.type)
          .thenReturn(DioExceptionType.badResponse);
      when(() => mockResponse.statusCode).thenReturn(412);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<ValidationFailedException>()),
      );
    });

    test('should throw ValidationFailedException if status code is 422', () {
      when(() => mockDioException.type)
          .thenReturn(DioExceptionType.badResponse);
      when(() => mockResponse.statusCode).thenReturn(422);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<ValidationFailedException>()),
      );
    });

    test('should throw InternalServerErrorException if status code is 500', () {
      when(() => mockDioException.type)
          .thenReturn(DioExceptionType.badResponse);
      when(() => mockResponse.statusCode).thenReturn(500);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<InternalServerErrorException>()),
      );
    });

    test('should throw BadCertificateException if bad certificate', () {
      when(() => mockDioException.type)
          .thenReturn(DioExceptionType.badCertificate);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<BadCertificateException>()),
      );
    });

    test('should throw NoInternetConnectionException if connection error', () {
      when(() => mockDioException.type)
          .thenReturn(DioExceptionType.connectionError);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<NoInternetConnectionException>()),
      );
    });

    test('should throw NoInternetConnectionException if unknown error', () {
      when(() => mockDioException.type).thenReturn(DioExceptionType.unknown);

      expect(
        () => errorInterceptor.onError(
            mockDioException, mockErrorInterceptorHandler),
        throwsA(isA<NoInternetConnectionException>()),
      );
    });

    test('should call next if cancel', () {
      when(() => mockDioException.type).thenReturn(DioExceptionType.cancel);

      errorInterceptor.onError(mockDioException, mockErrorInterceptorHandler);

      verify(() => mockErrorInterceptorHandler.next(mockDioException))
          .called(1);
    });
  });
}
