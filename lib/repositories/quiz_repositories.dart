import '../models/quiz/quiz_response.dart';
import '../services/quiz_services.dart';

abstract class QuizRepositories {
  Future<QuizResponse> getQuiz();
  Future<void> sendQuizData(Map<String, List<dynamic>> data);
}

class QuizRepositoryImpl implements QuizRepositories {
  final QuizServices quizService;

  QuizRepositoryImpl(this.quizService);
  @override
  Future<QuizResponse> getQuiz() {
    return quizService.getQuiz();
  }

  @override
  Future<void> sendQuizData(Map<String, List<dynamic>> data) {
    return quizService.sendQuizData(data);
  }
}
