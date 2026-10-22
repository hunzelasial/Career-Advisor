import 'api_client.dart';

class UserApi {
  UserApi({ApiClient? client}) : _client = client ?? ApiClient();

  final ApiClient _client;

  Future<Map<String, dynamic>> currentUser(String token) =>
      _client.get('/api/users/me', token: token);

  Future<Map<String, dynamic>> updateProfile(
    String token,
    Map<String, dynamic> fields,
  ) => _client.patch('/api/users/me', token, fields);

  Future<Map<String, dynamic>> completeOnboarding(String token) =>
      _client.post('/api/users/me/onboarding/complete', {}, token: token);

  Future<Map<String, dynamic>> notificationPreferences(String token) =>
      _client.get('/api/users/me/notification-preferences', token: token);

  Future<Map<String, dynamic>> updateNotificationPreferences(
    String token,
    Map<String, bool> changes,
  ) => _client.patch('/api/users/me/notification-preferences', token, changes);
}
