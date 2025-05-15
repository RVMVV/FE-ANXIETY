import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/quiz/quiz_response.dart';
import '../utils/constant_finals.dart';

class QuizServices {
  static const String _tokenKey = 'auth_token';
  static final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  Future<QuizResponse> getQuiz() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/$quizEndpoint'),
        headers:
            _headers..addAll({'Authorization': 'Bearer ${await getToken()}'}),
      );
      return QuizResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
}
