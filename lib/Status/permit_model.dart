import 'package:intl/intl.dart';

class PermitModel {
  final String description;
  final String selfieImage;
  final String workImage;
  final String status;
  final String permittedBy;
  final String address;
  final String name;
  final String date;
  final String category;
  final int categoryId;
  final String validFrom;
  final String validTill;
  final String contractorName;
  final String noOfWorkers;
  final String permitNo;
  final String extensionFrom;
  final String extensionTill;
  final String extensionReason;
  final String reason;
  final String title;
  final int id;
  final List<Answer> answers;
  final Extension extension;
  final List<TimelineModel> timelineData;

  PermitModel(
      {required this.description,
      required this.selfieImage,
      required this.title,
      required this.workImage,
      required this.status,
      required this.permittedBy,
      required this.address,
      required this.category,
      required this.categoryId,
      required this.date,
      required this.name,
      required this.validFrom,
      required this.validTill,
      required this.contractorName,
      required this.extensionFrom,
      required this.extensionReason,
      required this.extensionTill,
      required this.noOfWorkers,
      required this.permitNo,
      required this.id,
      required this.reason,
      required this.answers,
      required this.extension,
      required this.timelineData});

  factory PermitModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> answersList = json['answers'] ?? [];
    final List<Answer> parsedAnswers = List<Answer>.from(
      answersList.map((answer) => Answer.fromJson(answer)),
    );
    final Map<String, dynamic> extensionData = json['extension'] ?? {};
    final Extension extension = Extension.fromJson(extensionData);
    final List<dynamic> timelines = json['timeline'] ?? [];
    final List<TimelineModel> parsedTimeline = List<TimelineModel>.from(
      timelines.map((timeline) => TimelineModel.fromJson(timeline)),
    );

    return PermitModel(
        workImage: json['experience_image'] ?? "",
        permittedBy: json['permited_by'] ?? "",
        name: json['created_by'] ?? "",
        category: json['category'] ?? "",
        categoryId: json['category_id'],
        date:
            DateFormat('dd-MM-yyyy').format(DateTime.parse(json['created_at'])),
        address: json['location'] ?? "",
        reason: json['reason'] ?? "",
        validFrom: json['valid_from'] ?? "",
        validTill: json['valid_till'] ?? "",
        extensionFrom: json['extension_from'] ?? "",
        extensionTill: json['extension_till'] ?? "",
        extensionReason: json['extension_reason'] ?? "",
        contractorName: json['contractor_name'] ?? "",
        noOfWorkers: json['no_of_workers'] ?? "",
        permitNo: json['permit_no'] ?? "",
        id: json['id'] ?? "",
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        selfieImage: json['selfie_image'] ?? "",
        status: json['status'] ?? "",
        answers: parsedAnswers,
        extension: extension,
        timelineData: parsedTimeline);
  }
}

class Answer {
  final int answerId;
  final String answer;
  final String questionName;
  final String remarks;

  Answer(
      {required this.answerId,
      required this.answer,
      required this.questionName,
      required this.remarks});
  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
        answerId: json['answer_id'] ?? "",
        answer: json['answer'] ?? "",
        questionName: json['question_name'] ??
            "Mention any additional controls needed and implemented",
        remarks: json['remark'] ?? "none");
  }
}

class Extension {
  final int id;
  final String extensionFrom;
  final String extensionTill;
  final String extensionReason;
  final String otherReason;
  final String status;
  final List<Answer> extensionAnswers;

  Extension({
    required this.id,
    required this.extensionFrom,
    required this.extensionTill,
    required this.extensionReason,
    required this.otherReason,
    required this.status,
    required this.extensionAnswers,
  });

  factory Extension.fromJson(Map<String, dynamic> json) {
    final List<dynamic> extensionAnswersList = json['extension_answers'] ?? [];
    final List<Answer> parsedExtensionAnswers = List<Answer>.from(
      extensionAnswersList.map((answer) => Answer.fromJson(answer)),
    );

    return Extension(
      id: json['id'] ?? 0,
      extensionFrom: json['extension_from'] ?? "",
      extensionTill: json['extension_till'] ?? "",
      extensionReason: json['extension_reason'] ?? "",
      otherReason: json['other_reason'] ?? "",
      status: json['status'] ?? "",
      extensionAnswers: parsedExtensionAnswers,
    );
  }
}

class TimelineModel {
  final String status;
  final String desc;
  final String date;
  final String updatedBy;

  TimelineModel(
      {required this.status,
      required this.date,
      required this.desc,
      required this.updatedBy});

  factory TimelineModel.fromJson(Map<String, dynamic> json) {
    final createdDateTime = DateTime.parse(json['created_at']).toLocal();
    final istOffset = Duration(hours: 0, minutes: 0);
    // Convert the UTC time to IST
    final istDateTime = createdDateTime.add(istOffset);
    return TimelineModel(
        status: json['status'] ?? "",
        date: DateFormat('dd MMM, yyyy hh:mm a').format(istDateTime),
        desc: json['description'] ?? "",
        updatedBy: json['user_name'] ?? "");
  }
}
