import 'package:screening_app/models/auth/auth_response.dart';
import 'package:screening_app/services/auth_services.dart';

import '../models/user/user.dart';

abstract class AuthRepositories {
  Future<AuthResponse> login(String username, String password);
  Future<AuthResponse> register(
    String username,
    String password,
    String passwordConfirmation,
  );
  Future<User> getUser();
  Future<User> updateProfile(Map<String, dynamic> data);
  Future<String?> getToken();

  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepositories {
  final AuthServices authServices;

  AuthRepositoryImpl(this.authServices);

  @override
  Future<AuthResponse> login(String username, String password) {
    return authServices.login(username, password);
  }

  
  @override
  Future<AuthResponse> register(String username, String password, String passwordConfirmation) {
    return authServices.register(username, password, passwordConfirmation);
  }

  @override
  Future<String?> getToken() async {
    return authServices.getToken();
  }
  
  @override
  Future<void> logout() async {
    return authServices.clearToken();
  }
  
  @override
  Future<User> getUser() {
    return authServices.getUser();
  }
  
  @override
  Future<User> updateProfile(Map<String, dynamic> data) {
    return authServices.updateProfile(data);
  }
}
