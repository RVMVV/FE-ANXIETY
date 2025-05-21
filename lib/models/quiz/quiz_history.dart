import '../user/user.dart';

class QuizHistoryResponse {
  final String message;
  final List<QuizHistory> data;

  QuizHistoryResponse({
    required this.message,
    required this.data,
  });

  factory QuizHistoryResponse.fromJson(Map<String, dynamic> json) {
    return QuizHistoryResponse(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((item) => QuizHistory.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class QuizHistory {
  final String createdAt;
  final User user;
  final List<QuizResult> results;

  QuizHistory({
    required this.createdAt,
    required this.user,
    required this.results,
  });

  factory QuizHistory.fromJson(Map<String, dynamic> json) {
    return QuizHistory(
      createdAt: json['created_at'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((item) => QuizResult.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
      'user': user.toJson(),
      'results': results.map((item) => item.toJson()).toList(),
    };
  }
}


class QuizResult {
  final String id;
  final QuizType quizType;
  final String score;
  final String material;
  final String status;
  final String imagePath;

  QuizResult({
    required this.id,
    required this.quizType,
    required this.score,
    required this.material,
    required this.status,
    required this.imagePath
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      id: json['id'] as String,
      quizType: QuizType.fromJson(json['quiz_type'] as Map<String, dynamic>),
      score: json['score'] as String,
      material: json['material'] as String,
      status: json['status'] as String,
      imagePath: json['image_path'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quiz_type': quizType.toJson(),
      'score': score,
      'material': material,
      'status': status,
      'image_path': imagePath
    };
  }
}

class QuizType {
  final String id;
  final String type;

  QuizType({
    required this.id,
    required this.type,
  });

  factory QuizType.fromJson(Map<String, dynamic> json) {
    return QuizType(
      id: json['id'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
    };
  }
}