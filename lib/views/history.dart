// ignore_for_file: unused_field, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:screening_app/utils/constant_finals.dart';
import 'package:screening_app/viewmodels/quiz/quiz_cubit.dart';

import 'result.dart';
import 'widgets/history_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Screening',
          style: Styles.urbanistBold.copyWith(color: textColor, fontSize: 26),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: BlocBuilder<QuizCubit, QuizState>(
            builder: (context, state) {
              if (state is QuizLoading) {
                return SizedBox(
                  width: screenWidth,
                  height: screenHeight,
                  child: const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
                );
              } else if (state is QuizHistorySuccess) {
                final histories = state.quizHistoryList; // <-- gunakan List
                final sortedHistories = List.of(histories)..sort(
                  (a, b) => DateTime.parse(
                    b.createdAt,
                  ).compareTo(DateTime.parse(a.createdAt)),
                );
                return Column(
                  children:
                      sortedHistories.map((history) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => HasilPage(history: history),
                                ),
                              );
                            },
                            child: HistoryCard(
                              month:
                                  DateFormat('MMM')
                                      .format(DateTime.parse(history.createdAt))
                                      .toUpperCase(),
                              day: DateFormat(
                                'dd',
                              ).format(DateTime.parse(history.createdAt)),
                            ),
                          ),
                        );
                      }).toList(),
                );
              } else if (state is QuizHistoryError) {
                return SizedBox(
                  width: screenWidth,
                  height: screenHeight,
                  child: Center(
                    child: SvgPicture.asset(
                      icCross,
                      width: 250,
                      height: 250,
                      colorFilter: ColorFilter.mode(
                        textColor.withAlpha(15),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            },
          ),
        ),
      ),
    );
  }
}
