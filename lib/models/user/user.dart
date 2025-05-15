import 'profile.dart';

class User {
  final String id;
  final String username;
  Profile profile;

  User({
    required this.id,
    required this.username,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'profile': profile.toJson(),
      };
}