import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/quiz/quiz_response.dart';
import '../../repositories/quiz_repositories.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepositories quizRepository;
  QuizCubit(this.quizRepository) : super(QuizInitial());

  Future<void> getQuiz() async {
    emit(QuizLoading());
    try {
      final quizResponse = await quizRepository.getQuiz();
      emit(QuizSuccess(quizResponse));
    } catch (e) {
      emit(QuizError('Gagal Memuat Quiz : $e'));
    }
  }

  Future<void> sendQuizData(Map<String, List<dynamic>> data) async {
    emit(QuizLoading());
    try {
      await quizRepository.sendQuizData(data);
      emit(SendQuizSuccess(data));
    } catch (e, s) {
      print('Quiz Cubit : $e');
      print('Quiz Cubit : $s');
      emit(SendQuizError('Gagal Mengirim Quiz : $e'));
    }
  }
}
