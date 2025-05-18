import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screening_app/views/quiz.dart';
import 'package:intl/intl.dart';
import '../utils/constant_finals.dart';
import '../viewmodels/auth/auth_cubit.dart';
import '../viewmodels/quiz/quiz_cubit.dart';
import 'edit_profile.dart';

import 'result.dart';
import 'widgets/history_card.dart';
import 'widgets/warning_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizCubit>().getQuizHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.05, left: 20, right: 20),
        child: BlocBuilder<AuthCubit, AuthState>(
          bloc: context.read<AuthCubit>()..getUser(),
          builder: (context, authState) {
            if (authState is AuthLoading) {
              return SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: const Center(
                  child: CircularProgressIndicator(color: primaryColor),
                ),
              );
            }
            if (authState is GetUserSuccess) {
              final isProfileIncomplete =
                  authState.user.profile.height == null &&
                  authState.user.profile.weight == null;
              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Halo, ${authState.user.username}',
                      style: Styles.urbanistBold.copyWith(
                        color: textColor,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Bagaimana Kabarmu?',
                      style: Styles.urbanistMedium.copyWith(
                        color: textColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: onahau,
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    icMeditation,
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Text(
                                'Screening',
                                style: Styles.urbanistBold.copyWith(
                                  fontSize: 18,
                                  color: whiteColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          Row(
                            children: [
                              Text(
                                'Ayo ambil screening untuk mengetahui\ndirimu.',
                                style: Styles.urbanistMedium.copyWith(
                                  color: whiteColor,
                                  fontSize: 16,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QuizPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: onahau,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      isProfileIncomplete
                                          ? icForbidden
                                          : icArrow,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (isProfileIncomplete)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(),
                          ),
                        );
                      },
                      child: WarningCard(screenWidth: screenWidth),
                    ),
                  SizedBox(height: 50),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Riwayat Screening',
                      style: Styles.urbanistMedium.copyWith(
                        color: textColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<QuizCubit, QuizState>(
                    builder: (context, quizState) {
                      if (quizState is QuizHistorySuccess) {
                        final histories = quizState.quizHistoryList;
                        if (histories.isEmpty) {
                          return Text(
                            'Belum ada riwayat screening',
                            style: Styles.urbanistSemiBold.copyWith(
                              color: textColor,
                              fontSize: 18,
                            ),
                          );
                        }
                        final sortedHistories = List.of(histories)..sort(
                          (a, b) => DateTime.parse(
                            b.createdAt,
                          ).compareTo(DateTime.parse(a.createdAt)),
                        );
                        return Column(
                          children:
                              sortedHistories.take(3).map((history) {
                                // tampilkan 3 terbaru, atau semua jika mau
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  HasilPage(history: history),
                                        ),
                                      );
                                    },
                                    child: HistoryCard(
                                      month:
                                          DateFormat('MMM')
                                              .format(
                                                DateTime.parse(
                                                  history.createdAt,
                                                ),
                                              )
                                              .toUpperCase(),
                                      day: DateFormat('dd').format(
                                        DateTime.parse(history.createdAt),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        );
                      } else if (quizState is QuizHistoryError) {
                        return Expanded(
                          child: SizedBox(
                            width: screenWidth,
                            child: Center(
                              child: Text(
                                'Riwayat Tidak Tersedia',
                                style: Styles.urbanistRegular.copyWith(
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (quizState is QuizInitial) {
                        return Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      );
                    },
                  ),
                ],
              );
            }
            return SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Center(
                child: Text(
                  'Something went wrong',
                  style: Styles.urbanistMedium.copyWith(
                    color: textColor,
                    fontSize: 18,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
