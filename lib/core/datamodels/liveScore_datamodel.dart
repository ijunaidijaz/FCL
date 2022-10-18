// To parse this JSON data, do
//
//     final liveScoreDatamodel = liveScoreDatamodelFromJson(jsonString);

import 'dart:convert';

LiveScoreDatamodel liveScoreDatamodelFromJson(String str) =>
    LiveScoreDatamodel.fromJson(json.decode(str));

String liveScoreDatamodelToJson(LiveScoreDatamodel data) =>
    json.encode(data.toJson());

class LiveScoreDatamodel {
  LiveScoreDatamodel({
    this.status,
    this.data,
    this.errorMessage,
  });

  bool status;
  Data data;
  dynamic errorMessage;

  factory LiveScoreDatamodel.fromJson(Map<String, dynamic> json) =>
      LiveScoreDatamodel(
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
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String url;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        url: json["url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
