import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _api = ApiService.instance;
  static const _userEmailKey = 'user_email';

  Future<void> login(String email, String password) async {
    final response = await _api.post('/api/auth/login', body: {
      'email': email,
      'password': password,
    });

    final token = response['data']?['token'] as String?;
    if (token == null || token.isEmpty) {
      throw Exception('Login failed: missing token');
    }

    await _api.saveToken(token);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userEmailKey, email);
  }

  Future<void> signup(String name, String email, String password) async {
    await _api.post('/api/auth/signup', body: {
      'name': name,
      'email': email,
      'password': password,
    });
  }

  Future<void> logout() async {
    await _api.clearToken();
  }

  Future<void> forgotPassword(String email) async {
    await _api.post('/api/auth/forgot-password', body: {
      'email': email,
    });
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await _api.post('/api/auth/reset-password', body: {
      'token': token,
      'password': newPassword,
      'confirmPassword': confirmPassword,
    });
  }

  Future<bool> hasSession() async {
    final token = await _api.getToken();
    return token != null && token.isNotEmpty;
  }
}
