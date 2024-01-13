import 'package:intl/intl.dart';

class ExtensionModel {
  final int id;
  final String extensionFrom;
  final String extensionTill;
  final String extensionReason;
  final String otherReason;
  final String status;
  final List<Answer> extensionAnswers;

  ExtensionModel({
    required this.id,
    required this.extensionFrom,
    required this.extensionTill,
    required this.extensionReason,
    required this.otherReason,
    required this.status,
    required this.extensionAnswers,
  });

  factory ExtensionModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> answersList = json['extension_answers'] ?? [];
    final List<Answer> parsedAnswers = List<Answer>.from(
      answersList.map((answer) => Answer.fromJson(answer)),
    );

    return ExtensionModel(
      id: json['id'] ?? 0,
      extensionFrom: json['extension_from'] ?? "",
      extensionTill: json['extension_till'] ?? "",
      extensionReason: json['extension_reason'] ?? "",
      otherReason: json['other_reason'] ?? "",
      status: json['status'] ?? "",
      extensionAnswers: parsedAnswers,
    );
  }
}

class Answer {
  final int answerId;
  final int extensionId;
  final String answer;
  final String remark;
  final int permitId;
  final int questionId;
  final int questionNo;
  final String questionName;

  Answer({
    required this.answerId,
    required this.extensionId,
    required this.answer,
    required this.remark,
    required this.permitId,
    required this.questionId,
    required this.questionNo,
    required this.questionName,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answerId: json['answer_id'] ?? 0,
      extensionId: json['extension_id'] ?? 0,
      answer: json['answer'] ?? "",
      remark: json['remark'] ?? "",
      permitId: json['permit_id'] ?? 0,
      questionId: json['question_id'] ?? 0,
      questionNo: json['question_no'] ?? 0,
      questionName: json['question_name'] ?? "",
    );
  }
}

class TimelineModel {
  final int id;
  final int permitId;
  final int userId;
  final String description;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String updatedBy;

  TimelineModel({
    required this.id,
    required this.permitId,
    required this.userId,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory TimelineModel.fromJson(Map<String, dynamic> json) {
    return TimelineModel(
      id: json['id'] ?? 0,
      permitId: json['permit_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      description: json['description'] ?? "",
      status: json['status'] ?? "",
      createdAt: DateFormat('dd-MM-yyyy').format(DateTime.parse(json['created_at'])),
      updatedAt: DateFormat('dd-MM-yyyy').format(DateTime.parse(json['updated_at'])),
      updatedBy: json['user_name'] ?? "",
    );
  }
}
