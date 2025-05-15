import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user/user.dart';
import '../../repositories/auth_repositories.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.repository) : super(AuthInitial());
  final AuthRepositories repository;

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      final authResponse = await repository.login(username, password);
      emit(
        AuthLoginSuccess(
          message: authResponse.message,
          user: authResponse.user, // Kirim data User ke state
        ),
      );
    } catch (e) {
      emit(AuthLoginError(message: 'Login Gagal'));
    }
  }

  Future<void> register(
    String username,
    String password,
    String passwordConfirmation,
  ) async {
    emit(AuthLoading());
    try {
      await repository.register(username, password, passwordConfirmation);
      emit(AuthRegisterSuccess(message: 'Register Berhasil'));
    } catch (e) {
      emit(AuthRegisterError('Register Gagal'));
    }
  }

  Future<void> getUser() async {
    emit(AuthLoading());
    try {
      final user = await repository.getUser();
      emit(GetUserSuccess(user));
    } catch (e) {
      emit(GetUserError('Get User Gagal'));
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    emit(AuthLoading());
    try {
      final updatedUser = await repository.updateProfile(data);
      emit(UpdateUserSuccess(updatedUser));
    } catch (e) {
      emit(UpdateUserError('Get User Gagal'));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await repository.logout(); // Hapus token dari SharedPreferences
      emit(
        AuthLogoutSuccess('User logged out successfully'),
      ); // Kembali ke state awal
    } catch (e) {
      emit(AuthLoginError(message: 'Logout gagal'));
    }
  }
}
