import 'package:dio/dio.dart';
import 'package:fitwiz/core/repositories/token_repository.dart';
import 'package:fitwiz/core/services/api_service.dart';
import 'package:fitwiz/features/auth/data/models/register_user_data.dart';
import 'package:fitwiz/features/auth/data/models/user.dart';
import 'package:fitwiz/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

class MockTokenRepository extends Mock implements TokenRepository {}

class MockUser extends Mock implements User {}

void main() {
  late MockApiService mockApiService;
  late MockTokenRepository mockTokenRepository;
  late AuthRepository authRepository;

  setUp(() {
    mockApiService = MockApiService();
    mockTokenRepository = MockTokenRepository();
    authRepository = AuthRepository(mockApiService, mockTokenRepository);
  });

  group('AuthRepository', () {
    test('should login user and return user profile', () async {
      final response = Response(
        requestOptions: RequestOptions(path: '/auth/login'),
        data: {
          'access_token': 'valid-access-token',
          'refresh_token': 'valid-refresh-token',
        },
      );

      when(() => mockApiService.post("/auth/login", data: any(named: "data")))
          .thenAnswer((_) async => response);

      when(() => mockTokenRepository.saveAccessToken("valid-access-token"))
          .thenAnswer((_) async {});

      when(() => mockTokenRepository.saveRefreshToken("valid-refresh-token"))
          .thenAnswer((_) async {});

      final userResponse = Response(
        requestOptions: RequestOptions(path: '/me/profile'),
        data: {
          "date_of_birth": "2004-06-12",
          "email": "piyushsvps@gmail.com",
          "gender": "Male",
          "id": 2,
          "is_admin": true,
          "name": "Piyush",
          "salutation": "Mr"
        },
      );

      when(() => mockApiService.get("/me/profile"))
          .thenAnswer((_) async => userResponse);

      final user = await authRepository.login("testEmail", "testPassword");

      expect(user, isA<User>());
      expect(user.email, equals("piyushsvps@gmail.com"));
      expect(user.name, equals("Piyush"));
      expect(user.isAdmin, equals(true));
      expect(user.salutation, equals("Mr"));
      expect(user.gender, equals("Male"));
      expect(user.dateOfBirth, equals(DateTime(2004, 06, 12)));
      verify(() => mockTokenRepository.saveAccessToken("valid-access-token"))
          .called(1);
      verify(() => mockTokenRepository.saveRefreshToken("valid-refresh-token"))
          .called(1);
      verify(() => mockApiService.get("/me/profile")).called(1);
    });

    test('should return user profile if token is not expired', () async {
      final userResponse = Response(
        requestOptions: RequestOptions(path: '/me/profile'),
        data: {
          "date_of_birth": "2004-06-12",
          "email": "piyushsvps@gmail",
          "gender": "Male",
          "id": 2,
          "is_admin": true,
          "name": "Piyush",
          "salutation": "Mr"
        },
      );

      when(() => mockApiService.get("/me/profile"))
          .thenAnswer((_) async => userResponse);

      when(() => mockTokenRepository.getAccessToken())
          .thenAnswer((_) async => "valid-access-token");

      final user = await authRepository.fetchFromLocal();

      expect(user, isA<User>());
      expect(user!.email, equals("piyushsvps@gmail"));
      expect(user.name, equals("Piyush"));
      expect(user.isAdmin, equals(true));
      expect(user.salutation, equals("Mr"));
      expect(user.gender, equals("Male"));
      expect(user.dateOfBirth, equals(DateTime(2004, 06, 12)));
      verify(() => mockApiService.get("/me/profile")).called(1);
    });

    test('should return null if token is expired', () async {
      when(() => mockTokenRepository.getAccessToken())
          .thenAnswer((_) async => null);

      final user = await authRepository.fetchFromLocal();

      expect(user, isNull);
    });

    test('should logout user', () async {
      when(() => mockTokenRepository.clearTokens()).thenAnswer((_) async {});

      await authRepository.logout();

      verify(() => mockTokenRepository.clearTokens()).called(1);
    });

    test('should register user and return user profile', () async {
      final response = Response(
        requestOptions: RequestOptions(path: '/auth/login'),
        data: {
          'access_token': 'valid-access-token',
          'refresh_token': 'valid-refresh-token',
        },
      );

      when(() => mockApiService.post("/auth/login", data: any(named: "data")))
          .thenAnswer((_) async => response);

      when(() => mockTokenRepository.saveAccessToken("valid-access-token"))
          .thenAnswer((_) async {});

      when(() => mockTokenRepository.saveRefreshToken("valid-refresh-token"))
          .thenAnswer((_) async {});

      final userResponse = Response(
        requestOptions: RequestOptions(path: '/me/profile'),
        data: {
          "date_of_birth": "2004-06-12",
          "email": "piyushsvps@gmail.com",
          "gender": "Male",
          "id": 2,
          "is_admin": true,
          "name": "Piyush",
          "salutation": "Mr"
        },
      );

      when(() =>
              mockApiService.post("/auth/register", data: any(named: "data")))
          .thenAnswer((_) async => userResponse);

      when(() => mockApiService.get("/me/profile"))
          .thenAnswer((_) async => userResponse);

      final user = await authRepository.register(RegisterUserData(
        salutation: "Mr",
        name: "Piyush",
        gender: "Male",
        dateOfBirth: DateTime(2004, 06, 12),
        email: "piyushsvps@gmail.com",
        password: "testPassword",
      ));

      expect(user, isA<User>());
      expect(user.email, equals("piyushsvps@gmail.com"));
      expect(user.name, equals("Piyush"));
      expect(user.isAdmin, equals(true));
      expect(user.salutation, equals("Mr"));
      expect(user.gender, equals("Male"));
      expect(user.dateOfBirth, equals(DateTime(2004, 06, 12)));
      verify(() => mockTokenRepository.saveAccessToken("valid-access-token"))
          .called(1);
      verify(() => mockTokenRepository.saveRefreshToken("valid-refresh-token"))
          .called(1);
      verify(() => mockApiService.get("/me/profile")).called(1);
    });
  });
}
