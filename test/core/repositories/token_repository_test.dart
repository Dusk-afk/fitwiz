import 'package:fitwiz/core/repositories/token_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fitwiz/data/string_constants.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late TokenRepository tokenRepository;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    // Initialize the mock storage and the repository
    mockStorage = MockFlutterSecureStorage();
    tokenRepository = TokenRepository(mockStorage);
  });

  group('TokenRepository', () {
    test('saveAccessToken should write token to storage', () async {
      const token = 'test-access-token';

      when(() => mockStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'))).thenAnswer((_) async {});

      await tokenRepository.saveAccessToken(token);

      verify(() => mockStorage.write(
          key: StringConstants.ACCESS_TOKEN_KEY, value: token)).called(1);
    });

    test('getAccessToken should return token from storage', () async {
      const token = 'test-access-token';

      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => token);

      final result = await tokenRepository.getAccessToken();

      expect(result, token);
    });

    test('clearTokens should delete tokens from storage', () async {
      when(() => mockStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});

      await tokenRepository.clearTokens();

      verify(() => mockStorage.delete(key: StringConstants.ACCESS_TOKEN_KEY))
          .called(1);
      verify(() => mockStorage.delete(key: StringConstants.REFRESH_TOEN_KEY))
          .called(1);
    });
  });
}
