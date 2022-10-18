// To parse this JSON data, do
//
//     final notificationsDatamodel = notificationsDatamodelFromJson(jsonString);

import 'dart:convert';

NotificationsDatamodel notificationsDatamodelFromJson(String str) =>
    NotificationsDatamodel.fromJson(json.decode(str));

String notificationsDatamodelToJson(NotificationsDatamodel data) =>
    json.encode(data.toJson());

class NotificationsDatamodel {
  NotificationsDatamodel({
    this.status,
    this.data,
    this.errorMessage,
  });

  bool status;
  Data data;
  dynamic errorMessage;

  factory NotificationsDatamodel.fromJson(Map<String, dynamic> json) =>
      NotificationsDatamodel(
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
    this.message,
    this.type,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String message;
  String type;
  dynamic userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        message: json["message"],
        type: json["type"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "type": type,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
