class QuizResponse {
  final String message;
  final List<QuizTypeData> data;

  QuizResponse({
    required this.message,
    required this.data,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => QuizTypeData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class QuizTypeData {
  final QuizType quizType;
  final List<Quiz> quizzes;

  QuizTypeData({
    required this.quizType,
    required this.quizzes,
  });

  factory QuizTypeData.fromJson(Map<String, dynamic> json) {
    return QuizTypeData(
      quizType: QuizType.fromJson(json['quiz_type'] as Map<String, dynamic>),
      quizzes: (json['quizzes'] as List<dynamic>)
          .map((e) => Quiz.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quiz_type': quizType.toJson(),
      'quizzes': quizzes.map((e) => e.toJson()).toList(),
    };
  }
}

class QuizType {
  final String id;
  final String name;

  QuizType({
    required this.id,
    required this.name,
  });

  factory QuizType.fromJson(Map<String, dynamic> json) {
    return QuizType(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Quiz {
  final String? id;
  final String? title;
  final String? type;
  final String? question;
  final List<Question>? questions;

  Quiz({
    this.id,
    this.title,
    this.type,
    this.question,
    this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      question: json['question'] as String?,
      questions: json['questions'] != null
          ? (json['questions'] as List<dynamic>)
              .map((e) => Question.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (question != null) 'question': question,
      if (questions != null) 'questions': questions!.map((e) => e.toJson()).toList(),
    };
  }
}

class Question {
  final String id;
  final String question;

  Question({
    required this.id,
    required this.question,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      question: json['question'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
    };
  }
}