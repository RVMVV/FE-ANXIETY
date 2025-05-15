import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screening_app/viewmodels/auth/auth_cubit.dart';

import '../utils/constant_finals.dart';
import '../utils/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isObscure = true;
  final _formKey = GlobalKey<FormState>();

  void _togglePasswordVisibility() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

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
                  if (state is AuthRegisterError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: warningColor,
                        duration: const Duration(milliseconds: 2500),
                        content: Text(state.message),
                      ),
                    );
                  }
                  if (state is AuthRegisterSuccess) {
                    Navigator.pushReplacementNamed(context, '/login');
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
                          'Daftar',
                          style: Styles.urbanistBold.copyWith(
                            fontSize: 45,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          'dan mulai screening',
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
                        const SizedBox(height: 32),
                        Text(
                          'Konfirmasi Password',
                          style: Styles.urbanistRegular.copyWith(
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordConfirmationController,
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
                            hintText: 'Konfirmasi Password',
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
                                'Daftar',
                                style: Styles.urbanistBold.copyWith(
                                  fontSize: 16,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              return;
                            }
                            register();
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

  register() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String passwordConfirmation = _passwordConfirmationController.text;
    cubit.register(username, password, passwordConfirmation);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }
}
