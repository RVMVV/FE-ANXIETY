// ignore_for_file: unused_field, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/constant_finals.dart';
import '../viewmodels/auth/auth_cubit.dart';
import 'edit_profile.dart';
import 'login.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Profile',
          style: Styles.urbanistBold.copyWith(color: textColor, fontSize: 26),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is GetUserError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is GetUserSuccess) {
                return Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(20),
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: [
                      BoxShadow(
                        color: textColor.withAlpha(20),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nama',
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              state.user.username ,
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Umur',
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${state.user.profile.age.toString()} Tahun',
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Berat badan',
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${state.user.profile.weight.toString()} Kg',
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tinggi badan',
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${state.user.profile.height.toString()} cm',
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Jenis kelamin',
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              state.user.profile.gender.toString() ,
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tingkat pendidikan',
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              state.user.profile.education.toString() ,
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pekerjaan',
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              state.user.profile.occupation.toString() ,
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Status pernikahan',
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              state.user.profile.marriage.toString() ,
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lama menderita DM',
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              state.user.profile.duration.toString() ,
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Riwayat keluarga menderita DM',
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              state.user.profile.history.toString(),
                              style: Styles.urbanistSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                );
              }
              return SizedBox();
            },
          ),
          const SizedBox(height: 30),
          Container(height: 5, color: gapColor),
          const SizedBox(height: 20),
          InkWell(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: screenWidth,
              height: 60,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: textColor.withAlpha(20),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    icEdit,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 25),
                  Text(
                    'Edit data profile',
                    style: Styles.urbanistSemiBold.copyWith(
                      color: textColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          InkWell(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: screenWidth,
              height: 60,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: textColor.withAlpha(20),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    icLogOut,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      warningColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 25),
                  Text(
                    'Keluar',
                    style: Styles.urbanistSemiBold.copyWith(
                      color: warningColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () async {
              context.read<AuthCubit>().logout();
              // final authService = AuthServices();
              // authService.clearToken();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
