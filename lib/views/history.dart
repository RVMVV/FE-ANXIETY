// ignore_for_file: unused_field, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:screening_app/utils/constant_finals.dart';
import 'package:screening_app/viewmodels/quiz/quiz_cubit.dart';

import 'result.dart';
import 'widgets/history_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
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
              print(state);
              if (state is QuizLoading) {
                return Center(
                  child: CircularProgressIndicator(color: primaryColor),
                );
              } else if (state is QuizHistorySuccess) {
                final history = state.quizHistory;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 16),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HasilPage(),
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
                    ),
                  ],
                );
              } else if (state is QuizHistoryError) {
                return Center(
                  child: Text(
                    'Something Wrong',
                    style: Styles.urbanistBold.copyWith(
                      color: textColor,
                      fontSize: 18,
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
