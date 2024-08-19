import 'package:fitwiz/core/interceptors/token_interceptor.dart';
import 'package:fitwiz/core/repositories/token_repository.dart';
import 'package:fitwiz/core/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(const FlutterSecureStorage());
  locator.registerSingleton(TokenRepository(
    locator<FlutterSecureStorage>(),
  ));
  locator.registerSingleton(TokenInterceptor(
    locator<TokenRepository>(),
  ));
  locator.registerSingleton(ApiService(
    locator<TokenInterceptor>(),
  ));
}
