import 'package:fitwiz/core/interceptors/token_interceptor.dart';
import 'package:fitwiz/core/repositories/token_repository.dart';
import 'package:fitwiz/core/services/api_service.dart';
import 'package:fitwiz/features/address/data/repositories/address_repository.dart';
import 'package:fitwiz/features/address/presentation/blocs/address/address_bloc.dart';
import 'package:fitwiz/features/auth/data/repositories/auth_repository.dart';
import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/features/event/presentation/blocs/bloc/my_events_bloc.dart';
import 'package:fitwiz/features/event/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:fitwiz/features/event/data/repositories/event_repository.dart';
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
  locator.registerSingleton(AuthRepository(
    locator<ApiService>(),
    locator<TokenRepository>(),
  ));
  locator.registerSingleton(EventRepository(
    locator<ApiService>(),
  ));
  locator.registerSingleton(AddressRepository(
    locator<ApiService>(),
  ));
  locator.registerSingleton(AuthBloc());
  locator.registerSingleton(EventsBloc(
    locator<EventRepository>(),
  ));
  locator.registerSingleton(MyEventsBloc(
    locator<AuthBloc>(),
    locator<EventsBloc>(),
    locator<EventRepository>(),
  ));
  locator.registerSingleton(AddressBloc(
    locator<AddressRepository>(),
  ));
}
