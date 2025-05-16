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

  Future<void> sendQuizData(Map<String, List<dynamic>> data) async {
    try {
      final quizData = <Map<String, dynamic>>[];
      data.entries.forEach(
        (element) => quizData.add({
          'quiz_type_id': element.key,
          'values': element.value,
        }),
      );
      final response = await http.post(
        Uri.parse('$apiUrl/$quizEndpoint/store'),
        headers:
            _headers..addAll({'Authorization': 'Bearer ${await getToken()}'}),
        body: jsonEncode(quizData),
      );
      print(quizData);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
}
