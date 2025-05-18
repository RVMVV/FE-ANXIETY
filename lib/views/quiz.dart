import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screening_app/views/result.dart';

import '../models/quiz/quiz_response.dart';
import '../utils/constant_finals.dart';
import '../viewmodels/quiz/quiz_cubit.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  String _currentQuizType = 'HARS'; // Tipe kuis aktif
  final Map<String, List<double>> _sliderValues =
      {}; // Simpan nilai slider per tipe kuis

  @override
  void initState() {
    super.initState();
    context.read<QuizCubit>().getQuiz();
  }

  void _switchToNextQuizType() {
    setState(() {
      if (_currentQuizType == 'HARS') {
        _currentQuizType = 'MSPSS';
      } else if (_currentQuizType == 'MSPSS') {
        _currentQuizType = 'DQoL';
      } else if (_currentQuizType == 'DQoL') {
        context.read<QuizCubit>().sendQuizData(_sliderValues);
        return;
      }
      _currentPageIndex = 0;
      _pageController.jumpToPage(0); // Reset PageView
    });
  }

  // Label untuk slider
  final List<String> sliderLabelsMSPSS = [
    'Sangat Tidak Setuju',
    'Tidak Setuju',
    'Agak Tidak Setuju',
    'Netral',
    'Agak Setuju',
    'Setuju',
    'Sangat Setuju',
  ];

  final List<String> sliderLabelsQDoL1 = [
    'Tidak Puas',
    'Cukup Tidak Puas',
    'Netral',
    'Cukup Puas',
    'Sangat Puas',
  ];

  final List<String> sliderLabelsQDoL2 = [
    'Tidak Pernah',
    'Jarang',
    'Kadang-Kadang',
    'Sering',
    'Selalu',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizCubit, QuizState>(
      listener: (context, state) {
        if (state is SendQuizSuccess) {
          // Setelah submit, ambil history terbaru
          context.read<QuizCubit>().getQuizHistory();
        }
        if (state is QuizHistorySuccess) {
          final latestHistory = state.quizHistoryList.first;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  HasilPage(history: latestHistory,)),
          );
        }
      },
      child: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: backgroundColor,
              child: Center(
                child: CircularProgressIndicator(color: primaryColor),
              ),
            );
          } else if (state is QuizSuccess) {
            final quizData = state.quizResponse.data;
            // Ambil data untuk tipe kuis aktif
            final currentQuiz = quizData.firstWhere(
              (data) => data.quizType.name == _currentQuizType,
              orElse: () => quizData[0], // Fallback ke data pertama
            );
            final quizzes = currentQuiz.quizzes;
            final quizTypeId = currentQuiz.quizType.id; // ID quiz_type
            final isHars = _currentQuizType == 'HARS';
            final isDqol = _currentQuizType == 'DQoL';

            // Untuk DQoL, gabungkan semua questions dari quizzes
            List<Question> dqolQuestions = [];
            if (isDqol) {
              for (var quiz in quizzes) {
                if (quiz.questions != null) {
                  dqolQuestions.addAll(quiz.questions!);
                }
              }
            }

            final itemCount = isDqol ? dqolQuestions.length : quizzes.length;

            // Inisialisasi daftar nilai slider untuk tipe kuis jika belum ada
            if (!_sliderValues.containsKey(quizTypeId)) {
              _sliderValues[quizTypeId] = List<double>.filled(itemCount, 0.0);
            }

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Kuisioner $_currentQuizType',
                  style: Styles.urbanistBold.copyWith(
                    color: textColor,
                    fontSize: 26,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<QuizCubit>().getQuizHistory();
                  },
                  icon: SvgPicture.asset(icArrowBack),
                ),
              ),
              body: Column(
                children: [
                  // PageView untuk menampilkan pertanyaan
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                      },
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        String? questionText;
                        double sliderMin = 0;
                        double sliderMax =
                            isHars
                                ? 4
                                : isDqol
                                ? 4
                                : 6;
                        int? sliderDivisions =
                            isHars
                                ? 4
                                : isDqol
                                ? 4
                                : 6;
                        String? sliderLabel;

                        // Inisialisasi nilai slider untuk pertanyaan saat ini
                        final currentSliderValue =
                            _sliderValues[quizTypeId]![index];

                        if (isHars) {
                          // Untuk HARS: Tampilkan title dan daftar questions
                          final quiz = quizzes[index];
                          // Logging untuk debug
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  quiz.title ?? 'No Title',
                                  style: Styles.urbanistBold.copyWith(
                                    color: textColor,
                                    fontSize: 26,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Gejala yang dirasakan :',
                                  style: Styles.urbanistSemiBold.copyWith(
                                    color: textColor,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                if (quiz.questions != null)
                                  ...quiz.questions!.map((question) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: Text(
                                        '- ${question.question}',
                                        style: Styles.urbanistRegular.copyWith(
                                          color: textColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  })
                                else
                                  Text(
                                    'No Questions Available',
                                    style: Styles.urbanistRegular.copyWith(
                                      color: textColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                const SizedBox(height: 20),
                                Text(
                                  'Pilih Skor Skala:',
                                  style: Styles.urbanistSemiBold.copyWith(
                                    color: textColor,
                                    fontSize: 21,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Slider untuk HARS
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 8,
                                    activeTrackColor: primaryColor,
                                    inactiveTrackColor: primaryColor.withAlpha(
                                      30,
                                    ),
                                    thumbColor: primaryColor,
                                    overlayColor: primaryColor.withAlpha(50),
                                    valueIndicatorColor: whiteColor,
                                    valueIndicatorTextStyle: Styles
                                        .urbanistSemiBold
                                        .copyWith(
                                          color: textColor,
                                          fontSize: 20,
                                        ),
                                    valueIndicatorShape:
                                        RectangularSliderValueIndicatorShape(),
                                  ),
                                  child: Slider(
                                    value: currentSliderValue,
                                    min: sliderMin,
                                    max: sliderMax,
                                    divisions: sliderDivisions,
                                    label:
                                        currentSliderValue.round().toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        _sliderValues[quizTypeId]![index] =
                                            value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (isDqol) {
                          // Untuk DQoL: Tampilkan satu question per layar
                          final question = dqolQuestions[index];
                          questionText = question.question;
                          // Pilih label berdasarkan indeks pertanyaan
                          final labels =
                              index < 7 ? sliderLabelsQDoL1 : sliderLabelsQDoL2;
                          sliderLabel = labels[currentSliderValue.round()];
                        } else {
                          // Untuk MSPSS: Tampilkan satu question per layar
                          final quiz = quizzes[index];
                          questionText = quiz.question ?? 'No Question';
                          sliderLabel =
                              sliderLabelsMSPSS[currentSliderValue.round()];
                        }

                        if (!isHars) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  questionText,
                                  style: Styles.urbanistBold.copyWith(
                                    color: textColor,
                                    fontSize: 21,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                Spacer(),
                                Text(
                                  'Pilih Skor Skala:',
                                  style: Styles.urbanistSemiBold.copyWith(
                                    color: textColor,
                                    fontSize: 21,
                                  ),
                                ),
                                // Slider untuk MSPSS dan DQoL
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 8,
                                    activeTrackColor: primaryColor,
                                    inactiveTrackColor: primaryColor.withAlpha(
                                      30,
                                    ),
                                    thumbColor: primaryColor,
                                    overlayColor: primaryColor.withAlpha(50),
                                    valueIndicatorColor: whiteColor,
                                    valueIndicatorTextStyle: Styles
                                        .urbanistSemiBold
                                        .copyWith(
                                          color: textColor,
                                          fontSize: 20,
                                        ),
                                    valueIndicatorShape:
                                        RectangularSliderValueIndicatorShape(),
                                  ),
                                  child: Slider(
                                    value: currentSliderValue,
                                    min: sliderMin,
                                    max: sliderMax,
                                    divisions: sliderDivisions,
                                    label: sliderLabel,
                                    onChanged: (double value) {
                                      setState(() {
                                        _sliderValues[quizTypeId]![index] =
                                            value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 200),
                              ],
                            ),
                          );
                        }
                        return const SizedBox(); // Fallback, seharusnya tidak tercapai
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Tombol navigasi (Kembali dan Lanjut)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Tombol "Kembali"
                        if (_currentPageIndex > 0)
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: whiteColor,
                                shadowColor: textColor,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Kembali',
                                style: Styles.urbanistBold.copyWith(
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        if (_currentPageIndex > 0) const SizedBox(width: 20),
                        // Tombol "Lanjut"
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_currentPageIndex < itemCount - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                // Jika di halaman terakhir, pindah ke tipe berikutnya
                                _switchToNextQuizType();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shadowColor: textColor,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              _currentPageIndex < itemCount - 1
                                  ? 'Lanjut'
                                  : 'Selesai',
                              style: Styles.urbanistBold.copyWith(
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            );
          } else if (state is QuizError) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: backgroundColor,
              child: Center(
                child: Text(
                  state.message,
                  style: Styles.urbanistRegular.copyWith(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }
          return const Center(child: Text('No Data'));
        },
      ),
    );
  }
}
