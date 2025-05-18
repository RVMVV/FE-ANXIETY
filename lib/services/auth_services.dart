import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth/auth_response.dart';
import '../models/user/user.dart';
import '../utils/constant_finals.dart';

class AuthServices {
  static const String _tokenKey = 'auth_token';
  static final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<AuthResponse> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/$authEndpoint/login'),
        headers: _headers,
        body: jsonEncode({'username': username, 'password': password}),
      );
      final authResponse = AuthResponse.fromJson(jsonDecode(response.body));
      if (authResponse.token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, authResponse.token!);
      }
      return authResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<AuthResponse> register(
    String username,
    String password,
    String passwordConfirmation,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/$authEndpoint/register'),
        headers: _headers,
        body: jsonEncode({
          'username': username,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );
      return AuthResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> getUser() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/$authEndpoint/user'),
        headers:
            _headers..addAll({'Authorization': 'Bearer ${await getToken()}'}),
      );
      return User.fromJson(jsonDecode(response.body)['data']['user']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> updateProfile(Map<String, dynamic> data) async {
    try {
      // Hapus properti dengan nilai null dari data
      data.removeWhere((key, value) => value == null);
      final response = await http.put(
        Uri.parse('$apiUrl/$authEndpoint/user'),
        headers:
            _headers..addAll({'Authorization': 'Bearer ${await getToken()}'}),
        body: data.isNotEmpty ? jsonEncode(data) : null,
      );
      return User.fromJson(jsonDecode(response.body)['data']['user']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
