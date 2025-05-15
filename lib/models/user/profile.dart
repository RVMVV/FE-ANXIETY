// lib/models/profile.dart
class Profile {
  final String? name;
  final int? age;
  final int? height;
  final int? weight;
  final String? gender;
  final String? education;
  final String? occupation;
  final String? marriage;
  final String? duration;
  final String? history;

  Profile({
    this.name,
    this.age,
    this.height,
    this.weight,
    this.gender,
    this.education,
    this.occupation,
    this.marriage,
    this.duration,
    this.history,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    name: json['name'],
    age:
        json['age'] != null
            ? int.tryParse(json['age'].toString())
            : null, // Konversi ke int
    height:
        json['height'] != null
            ? int.tryParse(json['height'].toString())
            : null, // Konversi ke int
    weight:
        json['weight'] != null
            ? int.tryParse(json['weight'].toString())
            : null, // Konversi ke int
    gender: json['gender'],
    education: json['education'],
    occupation: json['occupation'],
    marriage: json['marriage'],
    duration: json['duration'],
    history: json['history'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
    'height': height,
    'weight': weight,
    'gender': gender,
    'education': education,
    'occupation': occupation,
    'marriage': marriage,
    'duration': duration,
    'history': history,
  };
}
