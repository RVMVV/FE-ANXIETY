import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screening_app/utils/validators.dart';

import '../utils/constant_finals.dart';
import '../viewmodels/auth/auth_cubit.dart';
import 'fragment.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscure = true;
  final _formKey = GlobalKey<FormState>();
  void _togglePasswordVisibility() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  late final AuthCubit cubit;
  late double screenWidth;
  late double screenHeight;

  @override
  void initState() {
    cubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoginError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: warningColor,
                        duration: const Duration(milliseconds: 2500),
                        content: Text(state.message),
                      ),
                    );
                  }
                  if (state is AuthLoginSuccess) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const FragmentPage()),
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return SizedBox(
                      height: screenHeight,
                      child: Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      ),
                    );
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo....',
                          style: Styles.urbanistBold.copyWith(
                            fontSize: 45,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          'Silahkan Masuk\ndan mulai screening',
                          style: Styles.urbanistMedium.copyWith(
                            fontSize: 30,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 50),
                        Text(
                          'Username',
                          style: Styles.urbanistRegular.copyWith(
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(hintText: 'Username'),
                          validator: Validators.validateUsername,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Password',
                          style: Styles.urbanistRegular.copyWith(
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: isObscure,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: borderColor,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                            hintText: 'Password',
                          ),
                          validator: Validators.validatePassword,
                        ),
                        SizedBox(height: 45),
                        InkWell(
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Masuk',
                                style: Styles.urbanistBold.copyWith(
                                  fontSize: 16,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            login();
                          },
                        ),
                        SizedBox(height: 50),
                        Center(
                          child: Text(
                            'Belum punya akun?',
                            style: Styles.urbanistRegular.copyWith(
                              fontSize: 14,
                              color: textColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: textColor.withAlpha(30),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Daftar',
                                style: Styles.urbanistBold.copyWith(
                                  fontSize: 16,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    cubit.login(username, password);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
