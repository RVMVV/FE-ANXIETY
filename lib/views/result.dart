import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screening_app/views/fragment.dart';
import 'package:intl/intl.dart';

import '../models/quiz/quiz_history.dart';
import '../utils/constant_finals.dart';
import '../viewmodels/quiz/quiz_cubit.dart';
import 'widgets/result_card.dart';

class HasilPage extends StatefulWidget {
  final QuizHistory history;
  const HasilPage({super.key, required this.history});
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
          if (state is QuizLoading) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: backgroundColor,
              child: Center(
                child: CircularProgressIndicator(color: primaryColor),
              ),
            );
          } else if (state is QuizHistorySuccess) {
            final quizHistory = widget.history; //
            final formattedDate = DateFormat('dd MMM yyyy, HH:mm').format(
              DateTime.parse(
                quizHistory.createdAt,
              ).toUtc().add(const Duration(hours: 7)),
            );

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
                      List<String> youtubeUrls = [];
                      String? materiText;

                      if (result.quizType.type.contains('HARS')) {
                        title = 'HARS';
                        icon = icMeditation;
                        youtubeUrls = [
                          'https://youtube.com/shorts/IRfl0_6x4sI?feature=share',
                          'https://youtube.com/shorts/_zeM0PTo_Pw?feature=share',
                          'https://youtube.com/shorts/zbM22_Ip1Kg?feature=share',
                          'https://youtu.be/0ihNo4FJinU',
                          'https://youtube.com/shorts/fxcTVg1E_wI?feature=share',
                        ];
                      } else if (result.quizType.type.contains('MSPSS')) {
                        title = 'MSPSS';
                        icon = icTripleUser;
                        materiText = materiMSPSS;
                      } else {
                        title = 'DQoL';
                        icon = icDone;
                        youtubeUrls = [
                          'https://youtube.com/shorts/Z0NNraPNpoc?feature=share',
                        ];
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ResultCard(
                          screenWidth: screenWidth,
                          icon: icon,
                          title: title,
                          status: result.status,
                          emotion: '$imgLoc${result.imagePath}',
                          score: result.score,
                          youtubeUrls: youtubeUrls,
                          materiText: materiText,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          } else if (state is QuizHistoryError) {
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
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: backgroundColor,
            child: Center(
              child: Text(
                'Tidak ada data riwayat',
                style: Styles.urbanistRegular.copyWith(
                  color: textColor,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
