import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fitwiz/data/string_constants.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenRepository {
  final FlutterSecureStorage _storage;

  TokenRepository(FlutterSecureStorage storage) : _storage = storage;

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: StringConstants.ACCESS_TOKEN_KEY, value: token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: StringConstants.ACCESS_TOKEN_KEY);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: StringConstants.ACCESS_TOKEN_KEY);
    await _storage.delete(key: StringConstants.REFRESH_TOEN_KEY);
  }

  Future<bool> isAccessTokenExpired() async {
    String? accessToken = await getAccessToken();
    if (accessToken == null) return true;
    return JwtDecoder.isExpired(accessToken);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: StringConstants.REFRESH_TOEN_KEY, value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: StringConstants.REFRESH_TOEN_KEY);
  }
}
