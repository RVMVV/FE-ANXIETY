import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:screening_app/utils/constant_finals.dart';
import 'package:screening_app/viewmodels/quiz/quiz_cubit.dart';
import 'package:screening_app/views/register.dart';

import 'repositories/auth_repositories.dart';
import 'repositories/quiz_repositories.dart';
import 'services/auth_services.dart';
import 'services/quiz_services.dart';
import 'viewmodels/auth/auth_cubit.dart';
import 'views/fragment.dart';
import 'views/home.dart';
import 'views/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final authService = AuthServices();
  final authRepository = AuthRepositoryImpl(authService);
  final quizRepository = QuizRepositoryImpl(QuizServices());
  final token = await authService.getToken();
  runApp(
    MyApp(
      initialRoute: token != null ? '/' : '/login',
      authRepository: authRepository,
      quizRepository: quizRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.initialRoute,
    required this.authRepository,
    required this.quizRepository,
  });

  final String initialRoute;
  final AuthRepositories authRepository;
  final QuizRepositories quizRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(authRepository)),
        BlocProvider(create: (context) => QuizCubit(quizRepository)),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: backgroundColor),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: textColor, // Set your desired cursor color here
          ),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: warningColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: warningColor, width: 1),
            ),
            hintStyle: Styles.urbanistMedium.copyWith(
              fontSize: 14,
              color: textColor.withValues(alpha: 0.5),
            ),
            counterStyle: Styles.urbanistExtraBold.copyWith(
              fontSize: 14,
              color: textColor.withValues(alpha: 0.5),
            ),
          ),
        ),
        initialRoute: initialRoute,
        routes: {
          '/': (context) => const FragmentPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}
