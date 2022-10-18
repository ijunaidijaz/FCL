// To parse this JSON data, do
//
//     final weekQuizResultDatamodel = weekQuizResultDatamodelFromJson(jsonString);

import 'dart:convert';

WeekQuizResultDatamodel weekQuizResultDatamodelFromJson(String str) =>
    WeekQuizResultDatamodel.fromJson(json.decode(str));

String weekQuizResultDatamodelToJson(WeekQuizResultDatamodel data) =>
    json.encode(data.toJson());

class WeekQuizResultDatamodel {
  WeekQuizResultDatamodel({
    this.status,
    this.data,
    this.errorMessage,
  });

  bool status;
  Data data;
  dynamic errorMessage;

  factory WeekQuizResultDatamodel.fromJson(Map<String, dynamic> json) =>
      WeekQuizResultDatamodel(
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
    this.mcqResult,
    this.tfResult,
    this.vsResult,
  });

  List<McqResult> mcqResult;
  List<TfResult> tfResult;
  List<VsResult> vsResult;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mcqResult: List<McqResult>.from(
        json["McqResult"].map((x) => McqResult.fromJson(x))),
    tfResult: List<TfResult>.from(
        json["TfResult"].map((x) => TfResult.fromJson(x))),
    vsResult: List<VsResult>.from(
        json["VsResult"].map((x) => VsResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "McqResult": List<dynamic>.from(mcqResult.map((x) => x.toJson())),
    "TfResult": List<dynamic>.from(tfResult.map((x) => x.toJson())),
    "VsResult": List<dynamic>.from(vsResult.map((x) => x.toJson())),
  };
}

class McqResult {
  McqResult({
    this.question,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.answer,
    this.bonus,
    this.answerStatus,
    this.userAnswer,
  });

  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String answer;
  bool bonus;
  bool answerStatus;
  String userAnswer;

  factory McqResult.fromJson(Map<String, dynamic> json) => McqResult(
    question: json["question"],
    option1: json["option1"],
    option2: json["option2"],
    option3: json["option3"],
    option4: json["option4"],
    answer: json["answer"],
    bonus: json["bonus"],
    answerStatus: json["answerStatus"],
    userAnswer: json["userAnswer"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "option1": option1,
    "option2": option2,
    "option3": option3,
    "option4": option4,
    "answer": answer,
    "bonus": bonus,
    "answerStatus": answerStatus,
    "userAnswer": userAnswer,
  };
}

class TfResult {
  TfResult({
    this.question,
    this.answer,
    this.bonus,
    this.answerStatus,
    this.userAnswer,
  });

  String question;
  bool answer;
  bool bonus;
  bool answerStatus;
  bool userAnswer;

  factory TfResult.fromJson(Map<String, dynamic> json) => TfResult(
    question: json["question"],
    answer: json["answer"],
    bonus: json["bonus"],
    answerStatus: json["answerStatus"],
    userAnswer: json["userAnswer"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
    "bonus": bonus,
    "answerStatus": answerStatus,
    "userAnswer": userAnswer,
  };
}

class VsResult {
  VsResult({
    this.question,
    this.answer,
    this.bonus,
    this.answerStatus,
    this.userAnswer,
  });

  String question;
  String answer;
  bool bonus;
  bool answerStatus;
  String userAnswer;

  factory VsResult.fromJson(Map<String, dynamic> json) => VsResult(
    question: json["question"],
    answer: json["answer"],
    bonus: json["bonus"],
    answerStatus: json["answerStatus"],
    userAnswer: json["userAnswer"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
    "bonus": bonus,
    "answerStatus": answerStatus,
    "userAnswer": userAnswer,
  };
}
