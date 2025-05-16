import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screening_app/views/fragment.dart';
import 'package:intl/intl.dart';

import '../utils/constant_finals.dart';
import '../viewmodels/quiz/quiz_cubit.dart';
import 'widgets/result_card.dart';

class HasilPage extends StatefulWidget {
  const HasilPage({super.key});

  @override
  State<HasilPage> createState() => _HasilPageState();
}

class _HasilPageState extends State<HasilPage> {
  @override
  void initState() {
    super.initState();
    context.read<QuizCubit>().getQuizHistory();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hasil',
          style: Styles.urbanistBold.copyWith(color: textColor, fontSize: 26),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const FragmentPage()),
              (route) => false,
            );
          },
          icon: SvgPicture.asset(icArrowBack),
        ),
      ),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          print(state);
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizHistorySuccess) {
            final quizHistory = state.quizHistory;
            final formattedDate = DateFormat(
              'dd MMM yyyy, HH:mm',
            ).format(DateTime.parse(quizHistory.createdAt));

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Riwayat: $formattedDate',
                      style: Styles.urbanistBold.copyWith(
                        color: textColor,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...quizHistory.results.map((result) {
                      String title;
                      String icon;
                      if (result.quizType.type.contains('HARS')) {
                        title = 'HARS';
                        icon = icMeditation;
                      } else if (result.quizType.type.contains('MSPSS')) {
                        title = 'MSPSS';
                        icon = icTripleUser;
                      } else {
                        title = 'DQoL';
                        icon = icDone;
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ResultCard(
                          screenWidth: screenWidth,
                          icon: icon,
                          title: title,
                          emotion:
                              imgBahagia, // Placeholder, klasifikasi di akhir
                          score: result.score,
                          material: result.material,
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          } else if (state is QuizHistoryError) {
            return Center(
              child: Text(
                state.message,
                style: Styles.urbanistRegular.copyWith(
                  color: textColor,
                  fontSize: 16,
                ),
              ),
            );
          }
          return Center(
            child: Text(
              'Tidak ada data riwayat',
              style: Styles.urbanistRegular.copyWith(
                color: textColor,
                fontSize: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}
