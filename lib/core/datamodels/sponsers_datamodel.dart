// To parse this JSON data, do
//
//     final sponsersDatamodel = sponsersDatamodelFromJson(jsonString);

import 'dart:convert';

SponsersDatamodel sponsersDatamodelFromJson(String str) =>
    SponsersDatamodel.fromJson(json.decode(str));

String sponsersDatamodelToJson(SponsersDatamodel data) =>
    json.encode(data.toJson());

class SponsersDatamodel {
  SponsersDatamodel({
    this.status,
    this.data,
    this.errorMessage,
  });

  bool status;
  Data data;
  dynamic errorMessage;

  factory SponsersDatamodel.fromJson(Map<String, dynamic> json) =>
      SponsersDatamodel(
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
    this.image,
    this.competitionId,
    this.createdAt,
    this.updatedAt,
    this.competition,
  });

  int id;
  String image;
  int competitionId;
  DateTime createdAt;
  DateTime updatedAt;
  Competition competition;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        image: json["image"],
        competitionId: json["competition_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        competition: Competition.fromJson(json["competition"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "competition_id": competitionId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "competition": competition.toJson(),
      };
}

class Competition {
  Competition({
    this.id,
    this.name,
    this.subAmount,
    this.status,
    this.description,
    this.expiredAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String subAmount;
  int status;
  dynamic description;
  DateTime expiredAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
        id: json["id"],
        name: json["name"],
        subAmount: json["subAmount"],
        status: json["status"],
        description: json["description"],
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
        "expired_at":
            "${expiredAt.year.toString().padLeft(4, '0')}-${expiredAt.month.toString().padLeft(2, '0')}-${expiredAt.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
