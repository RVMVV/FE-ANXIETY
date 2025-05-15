import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screening_app/views/quiz_another.dart';

import '../utils/constant_finals.dart';
import '../viewmodels/auth/auth_cubit.dart';
import 'edit_profile.dart';

import 'widgets/warning_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.05, left: 20, right: 20),
        child: SingleChildScrollView(
          child: BlocBuilder<AuthCubit, AuthState>(
            bloc: context.read<AuthCubit>()..getUser(),
            builder: (context, state) {
              if (state is AuthLoading) {
                return SizedBox(
                  width: screenWidth,
                  height: screenHeight,
                  child: const Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
                );
              }
              if (state is GetUserSuccess) {
                final isProfileIncomplete =
                    state.user.profile.height == null &&
                    state.user.profile.weight == null;
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Halo, ${state.user.username}',
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
                    //history card
                    // HistoryCard(month: 'JAN', day: '99'),
                    // SizedBox(height: 16),
                    // HistoryCard(month: 'FEB', day: '99'),
                    // SizedBox(height:  16),
                    // HistoryCard(month: 'MAR', day: '99'),
                    // SizedBox(height: 16),
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
      ),
    );
  }
}
