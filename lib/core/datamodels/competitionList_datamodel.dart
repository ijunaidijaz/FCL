// To parse this JSON data, do
//
//     final competitionListDatamodel = competitionListDatamodelFromJson(jsonString);

import 'dart:convert';

CompetitionListDatamodel competitionListDatamodelFromJson(String str) =>
    CompetitionListDatamodel.fromJson(json.decode(str));

String competitionListDatamodelToJson(CompetitionListDatamodel data) =>
    json.encode(data.toJson());

class CompetitionListDatamodel {
  CompetitionListDatamodel({
    this.status,
    this.data,
    this.errorMessage,
  });

  bool status;
  Data data;
  dynamic errorMessage;

  factory CompetitionListDatamodel.fromJson(Map<String, dynamic> json) =>
      CompetitionListDatamodel(
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
    this.name,
    this.subAmount,
    this.status,
    this.description,
    this.startDate,
    this.expiredAt,
    this.createdAt,
    this.updatedAt,
    this.subscribe,
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
  dynamic subscribe;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        subAmount: json["subAmount"],
        status: json["status"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        expiredAt: DateTime.parse(json["expired_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subscribe: json["subscribe"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subAmount": subAmount,
        "status": status,
        "description": description,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "expired_at":
            "${expiredAt.year.toString().padLeft(4, '0')}-${expiredAt.month.toString().padLeft(2, '0')}-${expiredAt.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "subscribe": subscribe,
      };
}
