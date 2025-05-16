part of 'quiz_cubit.dart';

@immutable
sealed class QuizState {}

final class QuizInitial extends QuizState {}

final class QuizLoading extends QuizState {}

final class QuizSuccess extends QuizState {
  final QuizResponse quizResponse;

  QuizSuccess(this.quizResponse);
}

final class QuizError extends QuizState {
  final String message;

  QuizError(this.message);
}

final class SendQuizSuccess extends QuizState {
  final Map<String, List<dynamic>> dataQuiz;

  SendQuizSuccess(this.dataQuiz);
}

final class SendQuizError extends QuizState {
  final String message;

  SendQuizError(this.message);
}

final class QuizHistorySuccess extends QuizState {
  final QuizHistory quizHistory;

  QuizHistorySuccess(this.quizHistory);
}

final class QuizHistoryError extends QuizState {
  final String message;

  QuizHistoryError(this.message);
}
