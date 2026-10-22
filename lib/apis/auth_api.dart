import 'api_client.dart';

class AuthApi {
  AuthApi({ApiClient? client}) : _client = client ?? ApiClient();

  final ApiClient _client;

  Future<Map<String, dynamic>> login(String email, String password) =>
      _client.post('/api/auth/login', {'email': email, 'password': password});

  Future<Map<String, dynamic>> signup({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
  }) => _client.post('/api/auth/signup', {
    'fullName': fullName,
    'phoneNumber': phoneNumber,
    'email': email,
    'password': password,
  });

  Future<Map<String, dynamic>> forgotPassword(String email) =>
      _client.post('/api/auth/password/forgot', {'email': email});

  Future<Map<String, dynamic>> verifyResetCode({
    required String email,
    required String code,
  }) => _client.post('/api/auth/password/verify-otp', {
    'email': email,
    'code': code,
  });

  Future<Map<String, dynamic>> resetPassword({
    required String resetTicket,
    required String newPassword,
  }) => _client.post('/api/auth/password/reset', {
    'resetTicket': resetTicket,
    'newPassword': newPassword,
  });

  Future<void> logout(String refreshToken) async {
    await _client.post('/api/auth/logout', {'refreshToken': refreshToken});
  }
}
