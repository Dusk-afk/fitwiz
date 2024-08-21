import 'package:bloc_test/bloc_test.dart';
import 'package:fitwiz/features/auth/data/models/user.dart';
import 'package:fitwiz/features/auth/data/repositories/auth_repository.dart';
import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUser extends Mock implements User {}

class MockException implements Exception {
  final String message;

  MockException(this.message);

  @override
  String toString() => message;
}

void main() {
  late AuthBloc authBloc;
  late MockAuthRepository mockAuthRepository;
  late MockUser mockUser;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(mockAuthRepository);
    mockUser = MockUser();
  });

  tearDown(() {
    authBloc.close();
  });

  blocTest(
    'should emit [AuthLoading, AuthLoggedIn] when login is successful',
    build: () {
      when(() => mockAuthRepository.login(any(), any())).thenAnswer(
        (_) async => mockUser,
      );

      return authBloc;
    },
    act: (bloc) {
      bloc.add(const AuthLogin(email: "testEmail", password: "testPassword"));
    },
    expect: () => <AuthState>[
      AuthLoading(),
      AuthLoggedIn(mockUser),
    ],
  );

  blocTest(
    'should emit [AuthLoading, AuthError, AuthLoggedOut] when login is unsuccessful',
    build: () {
      when(() => mockAuthRepository.login(any(), any())).thenThrow(
        MockException("Error logging in"),
      );

      return authBloc;
    },
    act: (bloc) {
      bloc.add(const AuthLogin(email: "testEmail", password: "testPassword"));
    },
    expect: () => <AuthState>[
      AuthLoading(),
      const AuthError("Error logging in"),
      AuthLoggedOut(),
    ],
  );

  blocTest(
    'should emit [AuthLoading, AuthLoggedOut] when logout is successful',
    build: () {
      when(() => mockAuthRepository.logout()).thenAnswer((_) async {});

      return authBloc;
    },
    act: (bloc) {
      bloc.add(AuthLogout());
    },
    expect: () => <AuthState>[
      AuthLoading(),
      AuthLoggedOut(),
    ],
  );

  blocTest(
    'should emit [AuthLoading, AuthError] when logout is unsuccessful',
    build: () {
      when(() => mockAuthRepository.logout()).thenThrow(
        MockException("Error logging out"),
      );

      return authBloc;
    },
    act: (bloc) {
      bloc.add(AuthLogout());
    },
    expect: () => <AuthState>[
      AuthLoading(),
      const AuthError("Error logging out"),
    ],
  );

  blocTest(
    'should emit [AuthLoading, AuthLoggedIn] when app is started and user is logged in',
    build: () {
      when(() => mockAuthRepository.fetchFromLocal()).thenAnswer(
        (_) async => mockUser,
      );

      return authBloc;
    },
    act: (bloc) {
      bloc.add(AppStarted());
    },
    expect: () => <AuthState>[
      AuthLoading(),
      AuthLoggedIn(mockUser),
    ],
  );

  blocTest(
    'should emit [AuthLoading, AuthLoggedOut] when app is started and user is not logged in',
    build: () {
      when(() => mockAuthRepository.fetchFromLocal()).thenAnswer(
        (_) async => null,
      );

      return authBloc;
    },
    act: (bloc) {
      bloc.add(AppStarted());
    },
    expect: () => <AuthState>[
      AuthLoading(),
      AuthLoggedOut(),
    ],
  );

  blocTest(
    'should emit [AuthLoading, AuthError, AuthLoggedOut] when app is started and an error occurs',
    build: () {
      when(() => mockAuthRepository.fetchFromLocal()).thenThrow(
        MockException("Error fetching user"),
      );

      return authBloc;
    },
    act: (bloc) {
      bloc.add(AppStarted());
    },
    expect: () => <AuthState>[
      AuthLoading(),
      const AuthError("Error fetching user"),
      AuthLoggedOut(),
    ],
  );
}
