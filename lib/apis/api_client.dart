import 'dart:convert';

import 'package:http/http.dart' as http;

import '../exceptions/api_exception.dart';

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  static final Uri _root = Uri.parse('https://130.210.46.232.sslip.io');
  final http.Client _client;

  Future<Map<String, dynamic>> get(String path, {String? token}) async {
    final response = await _client.get(
      _root.resolve(path),
      headers: {if (token != null) 'Authorization': 'Bearer $token'},
    );
    return _decode(response);
  }

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final response = await _client.post(
      _root.resolve(path),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
    return _decode(response);
  }

  Future<Map<String, dynamic>> patch(
    String path,
    String token,
    Map<String, dynamic> body,
  ) async {
    final response = await _client.patch(
      _root.resolve(path),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
    return _decode(response);
  }

  Map<String, dynamic> _decode(http.Response response) {
    dynamic decoded;
    try {
      decoded = response.body.isEmpty
          ? <String, dynamic>{}
          : jsonDecode(response.body);
    } on FormatException {
      decoded = <String, dynamic>{};
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = decoded is Map<String, dynamic>
          ? decoded['message'] ?? decoded['detail'] ?? decoded['error']
          : null;
      throw ApiException(
        statusCode: response.statusCode,
        message:
            message?.toString() ?? 'Request failed (${response.statusCode}).',
      );
    }
    return decoded is Map<String, dynamic> ? decoded : <String, dynamic>{};
  }
}
