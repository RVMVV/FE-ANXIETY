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
