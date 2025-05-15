
import '../user/user.dart';

class AuthResponse {
  final String message;
  final String? token; // Nullable karena register tidak mengembalikan token
  final User user;

  AuthResponse({
    required this.message,
    this.token,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        message: json['message'],
        token: json['data']['token'],
        user: User.fromJson(json['data']['user']),
      );
}