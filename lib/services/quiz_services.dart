import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/quiz/quiz_history.dart';
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
      await http.post(
        Uri.parse('$apiUrl/$quizEndpoint/store'),
        headers:
            _headers..addAll({'Authorization': 'Bearer ${await getToken()}'}),
        body: jsonEncode(quizData),
      );
    } catch (e, s) {
      print('Quiz Services - Send Quiz Data: $e');
      print('Quiz Services - Send Quiz Data: $s');
      throw Exception(e);
    }
  }

  Future<List<QuizHistory>> getQuizHistory() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/$quizEndpoint/history'),
        headers:
            _headers..addAll({'Authorization': 'Bearer ${await getToken()}'}),
      );
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      final historyResponse = QuizHistoryResponse.fromJson(jsonData);
      return historyResponse.data;
    } catch (e, s) {

      throw Exception('Error fetching quiz history: $e');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
}
