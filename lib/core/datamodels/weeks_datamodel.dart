// To parse this JSON data, do
//
//     final weeksDatamodel = weeksDatamodelFromJson(jsonString);

import 'dart:convert';

WeeksDatamodel weeksDatamodelFromJson(String str) =>
    WeeksDatamodel.fromJson(json.decode(str));

String weeksDatamodelToJson(WeeksDatamodel data) => json.encode(data.toJson());

class WeeksDatamodel {
  WeeksDatamodel({
    this.status,
    this.data,
    this.errorMessage,
  });

  bool status;
  Data data;
  dynamic errorMessage;

  factory WeeksDatamodel.fromJson(Map<String, dynamic> json) => WeeksDatamodel(
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
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.description,
    this.competitionId,
    this.expiredAt,
    this.createdAt,
    this.updatedAt,
    this.attempt,
    this.score,
  });

  int id;
  String title;
  dynamic description;
  int competitionId;
  DateTime expiredAt;
  DateTime createdAt;
  DateTime updatedAt;
  bool attempt;
  int score;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        competitionId: json["competition_id"],
        expiredAt: DateTime.parse(json["expired_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        attempt: json["attempt"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "competition_id": competitionId,
        "expired_at": expiredAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "attempt": attempt,
        "score": score,
      };
}
