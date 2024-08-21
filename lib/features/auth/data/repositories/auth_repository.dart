import 'package:fitwiz/core/repositories/token_repository.dart';
import 'package:fitwiz/core/services/api_service.dart';
import 'package:fitwiz/features/auth/data/models/user.dart';

class AuthRepository {
  final ApiService _apiService;
  final TokenRepository _tokenRepository;

  AuthRepository(this._apiService, this._tokenRepository);

  Future<User> login(String email, String password) async {
    final response = await _apiService.post('/auth/login', data: {
      'email': email,
      'password': password,
    });

    final accessToken = response.data['access_token'];
    final refreshToken = response.data['refresh_token'];

    await _tokenRepository.saveAccessToken(accessToken);
    await _tokenRepository.saveRefreshToken(refreshToken);

    return getProfile();
  }

  Future<User> getProfile() async {
    final response = await _apiService.get('/me/profile');
    return User.fromJson(response.data);
  }

  Future<User?> fetchFromLocal() async {
    final accessToken = await _tokenRepository.getAccessToken();
    if (accessToken == null) {
      return null;
    }

    return getProfile();
  }

  Future<void> logout() async {
    await _tokenRepository.clearTokens();
  }
}
