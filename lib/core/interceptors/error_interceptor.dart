import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions, err.response);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, err.response);
          case 401:
          case 403:
            throw UnauthorizedException(err.requestOptions, err.response);
          case 404:
            throw NotFoundException(err.requestOptions, err.response);
          case 405:
            throw MethodNotAllowedException(err.requestOptions, err.response);
          case 409:
            throw ConflictException(err.requestOptions, err.response);
          case 412:
          case 422:
            throw ValidationFailedException(err.requestOptions, err.response);
          case 500:
            throw InternalServerErrorException(
                err.requestOptions, err.response);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.badCertificate:
        throw BadCertificateException(err.requestOptions, err.response);
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(err.requestOptions, err.response);
    }

    return handler.next(err);
  }
}

class BadRequestException extends FitwizApiException {
  BadRequestException(RequestOptions r, Response? res)
      : super(requestOptions: r, res: res);
}

class InternalServerErrorException extends FitwizApiException {
  InternalServerErrorException(RequestOptions r, Response? res)
      : super(requestOptions: r, res: res);
}

class ConflictException extends FitwizApiException {
  ConflictException(RequestOptions r, Response? res)
      : super(requestOptions: r, res: res);
}

class UnauthorizedException extends FitwizApiException {
  UnauthorizedException(RequestOptions r, Response? res)
      : super(requestOptions: r, res: res);
}

class NotFoundException extends FitwizApiException {
  NotFoundException(RequestOptions r, Response? res)
      : super(requestOptions: r, res: res);
}

class NoInternetConnectionException extends FitwizApiException {
  NoInternetConnectionException(RequestOptions r, Response? res)
      : super(requestOptions: r, res: res);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends FitwizApiException {
  DeadlineExceededException(RequestOptions r, Response? res)
      : super(requestOptions: r, res: res);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

class ValidationFailedException extends FitwizApiException {
  ValidationFailedException(RequestOptions r, Response? res)
      : super(requestOptions: r, res: res);

  @override
  String toString() {
    String errorMessage = "Invalid input passed";
    try {
      errorMessage = res!.data['message'];
    } catch (e) {
      // pass
    }

    return errorMessage;
  }
}

class TokenExpiredException extends FitwizApiException {
  TokenExpiredException(RequestOptions r, Response? res)
      : super(requestOptions: r, res: res);

  @override
  String toString() {
    return 'Token expired, please login again.';
  }
}

class BadCertificateException extends FitwizApiException {
  BadCertificateException(RequestOptions r, Response? res)
      : super(requestOptions: r, res: res);

  @override
  String toString() {
    return 'Bad certificate, please try again.';
  }
}

class MethodNotAllowedException extends FitwizApiException {
  MethodNotAllowedException(RequestOptions r, Response? res)
      : super(requestOptions: r, res: res);

  @override
  String toString() {
    return 'Method not allowed';
  }
}

class FitwizApiException extends DioException {
  final Response? res;

  FitwizApiException({required super.requestOptions, this.res});

  @override
  String? get message {
    try {
      return res?.data['message'];
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() {
    return message ?? 'An error occurred';
  }
}
