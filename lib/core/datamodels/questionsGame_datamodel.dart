// To parse this JSON data, do
//
//     final questionsGameDatamodel = questionsGameDatamodelFromJson(jsonString);

import 'dart:convert';

QuestionsGameDatamodel questionsGameDatamodelFromJson(String str) => QuestionsGameDatamodel.fromJson(json.decode(str));

String questionsGameDatamodelToJson(QuestionsGameDatamodel data) => json.encode(data.toJson());

class QuestionsGameDatamodel {
  QuestionsGameDatamodel({
    this.status,
    this.data,
    this.errorMessage,
  });

  bool status;
  Data data;
  dynamic errorMessage;

  factory QuestionsGameDatamodel.fromJson(Map<String, dynamic> json) => QuestionsGameDatamodel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    errorMessage: json["errorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "errorMessage": errorMessage,
  };
}

class Data {
  Data({
    this.id,
    this.title,
    this.description,
    this.competitionId,
    this.createdAt,
    this.expiredAt,
    this.updatedAt,
    this.status,
    this.competition,
    this.questionMc,
    this.questionTf,
    this.questionVs,
    this.userMcqAnswer,
    this.userTfAnswer,
    this.userVsqAnswer,
    this.competitionNativeAdd,
  });

  int id;
  String title;
  dynamic description;
  int competitionId;
  DateTime createdAt;
  DateTime expiredAt;
  DateTime updatedAt;
  int status;
  Competition competition;
  List<QuestionMc> questionMc;
  List<QuestionTf> questionTf;
  List<QuestionV> questionVs;
  List<UserAnswer> userMcqAnswer;
  List<UserAnswer> userTfAnswer;
  List<UserAnswer> userVsqAnswer;
  List<CompetitionNativeAdd> competitionNativeAdd;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    competitionId: json["competition_id"],
    createdAt: DateTime.parse(json["created_at"]),
    expiredAt: DateTime.parse(json["expired_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    status: json["status"],
    competition: Competition.fromJson(json["competition"]),
    questionMc: List<QuestionMc>.from(json["question_mc"].map((x) => QuestionMc.fromJson(x))),
    questionTf: List<QuestionTf>.from(json["question_tf"].map((x) => QuestionTf.fromJson(x))),
    questionVs: List<QuestionV>.from(json["question_vs"].map((x) => QuestionV.fromJson(x))),
    userMcqAnswer: List<UserAnswer>.from(json["UserMcqAnswer"].map((x) => UserAnswer.fromJson(x))),
    userTfAnswer: List<UserAnswer>.from(json["UserTfAnswer"].map((x) => UserAnswer.fromJson(x))),
    userVsqAnswer: List<UserAnswer>.from(json["UserVsqAnswer"].map((x) => UserAnswer.fromJson(x))),
    competitionNativeAdd: List<CompetitionNativeAdd>.from(json["competitionNativeAdd"].map((x) => CompetitionNativeAdd.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "competition_id": competitionId,
    "created_at": createdAt.toIso8601String(),
    "expired_at": expiredAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "status": status,
    "competition": competition.toJson(),
    "question_mc": List<dynamic>.from(questionMc.map((x) => x.toJson())),
    "question_tf": List<dynamic>.from(questionTf.map((x) => x.toJson())),
    "question_vs": List<dynamic>.from(questionVs.map((x) => x.toJson())),
    "UserMcqAnswer": List<dynamic>.from(userMcqAnswer.map((x) => x.toJson())),
    "UserTfAnswer": List<dynamic>.from(userTfAnswer.map((x) => x.toJson())),
    "UserVsqAnswer": List<dynamic>.from(userVsqAnswer.map((x) => x.toJson())),
    "competitionNativeAdd": List<dynamic>.from(competitionNativeAdd.map((x) => x.toJson())),
  };
}

class Competition {
  Competition({
    this.id,
    this.name,
    this.subAmount,
    this.status,
    this.description,
    this.startDate,
    this.expiredAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String subAmount;
  int status;
  dynamic description;
  DateTime startDate;
  DateTime expiredAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
    id: json["id"],
    name: json["name"],
    subAmount: json["subAmount"],
    status: json["status"],
    description: json["description"],
    startDate: DateTime.parse(json["start_date"]),
    expiredAt: DateTime.parse(json["expired_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "subAmount": subAmount,
    "status": status,
    "description": description,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "expired_at": "${expiredAt.year.toString().padLeft(4, '0')}-${expiredAt.month.toString().padLeft(2, '0')}-${expiredAt.day.toString().padLeft(2, '0')}",
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class CompetitionNativeAdd {
  CompetitionNativeAdd({
    this.id,
    this.title,
    this.url,
    this.startDate,
    this.endDate,
    this.competitionId,
    this.image,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.createdAt,
    this.updatedAt,
    this.pictures,
  });

  int id;
  String title;
  String url;
  DateTime startDate;
  DateTime endDate;
  int competitionId;
  String image;
  String image2;
  String image3;
  String image4;
  String image5;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> pictures;

  factory CompetitionNativeAdd.fromJson(Map<String, dynamic> json) => CompetitionNativeAdd(
    id: json["id"],
    title: json["title"],
    url: json["url"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    competitionId: json["competition_id"],
    image: json["image"],
    image2: json["image2"],
    image3: json["image3"],
    image4: json["image4"],
    image5: json["image5"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pictures: List<String>.from(json["pictures"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "competition_id": competitionId,
    "image": image,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "image5": image5,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pictures": List<dynamic>.from(pictures.map((x) => x)),
  };
}

class QuestionMc {
  QuestionMc({
    this.id,
    this.question,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.answer,
    this.bonus,
    this.quizId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  dynamic answer;
  int bonus;
  int quizId;
  DateTime createdAt;
  DateTime updatedAt;

  factory QuestionMc.fromJson(Map<String, dynamic> json) => QuestionMc(
    id: json["id"],
    question: json["Question"],
    option1: json["option1"],
    option2: json["option2"],
    option3: json["option3"],
    option4: json["option4"],
    answer: json["answer"],
    bonus: json["bonus"],
    quizId: json["quiz_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Question": question,
    "option1": option1,
    "option2": option2,
    "option3": option3,
    "option4": option4,
    "answer": answer,
    "bonus": bonus,
    "quiz_id": quizId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class QuestionTf {
  QuestionTf({
    this.id,
    this.question,
    this.isCorrect,
    this.bonus,
    this.quizId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String question;
  dynamic isCorrect;
  int bonus;
  int quizId;
  DateTime createdAt;
  DateTime updatedAt;

  factory QuestionTf.fromJson(Map<String, dynamic> json) => QuestionTf(
    id: json["id"],
    question: json["Question"],
    isCorrect: json["is_correct"],
    bonus: json["bonus"],
    quizId: json["quiz_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Question": question,
    "is_correct": isCorrect,
    "bonus": bonus,
    "quiz_id": quizId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class QuestionV {
  QuestionV({
    this.id,
    this.question,
    this.v1Name,
    this.v1Image,
    this.v2Name,
    this.v2Image,
    this.answer,
    this.bonus,
    this.tie,
    this.quizId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String question;
  String v1Name;
  String v1Image;
  String v2Name;
  String v2Image;
  dynamic answer;
  int bonus;
  int tie;
  int quizId;
  DateTime createdAt;
  DateTime updatedAt;

  factory QuestionV.fromJson(Map<String, dynamic> json) => QuestionV(
    id: json["id"],
    question: json["Question"],
    v1Name: json["v1Name"],
    v1Image: json["v1image"],
    v2Name: json["v2Name"],
    v2Image: json["v2image"],
    answer: json["answer"],
    bonus: json["bonus"],
    tie: json["tie"],
    quizId: json["quiz_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Question": question,
    "v1Name": v1Name,
    "v1image": v1Image,
    "v2Name": v2Name,
    "v2image": v2Image,
    "answer": answer,
    "bonus": bonus,
    "tie": tie,
    "quiz_id": quizId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class UserAnswer {
  UserAnswer({
    this.id,
    this.userId,
    this.questionMcId,
    this.quizId,
    this.answer,
    this.createdAt,
    this.updatedAt,
    this.questionTfId,
    this.questionVsId,
  });

  int id;
  int userId;
  int questionMcId;
  int quizId;
  String answer;
  DateTime createdAt;
  DateTime updatedAt;
  int questionTfId;
  int questionVsId;

  factory UserAnswer.fromJson(Map<String, dynamic> json) => UserAnswer(
    id: json["id"],
    userId: json["user_id"],
    questionMcId: json["question_mc_id"] == null ? null : json["question_mc_id"],
    quizId: json["quiz_id"],
    answer: json["answer"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    questionTfId: json["question_tf_id"] == null ? null : json["question_tf_id"],
    questionVsId: json["question_vs_id"] == null ? null : json["question_vs_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "question_mc_id": questionMcId == null ? null : questionMcId,
    "quiz_id": quizId,
    "answer": answer,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "question_tf_id": questionTfId == null ? null : questionTfId,
    "question_vs_id": questionVsId == null ? null : questionVsId,
  };
}
