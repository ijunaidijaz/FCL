// To parse this JSON data, do
//
//     final generalAddsDatamodel = generalAddsDatamodelFromJson(jsonString);

import 'dart:convert';

GeneralAddsDatamodel generalAddsDatamodelFromJson(String str) =>
    GeneralAddsDatamodel.fromJson(json.decode(str));

String generalAddsDatamodelToJson(GeneralAddsDatamodel data) =>
    json.encode(data.toJson());

class GeneralAddsDatamodel {
  GeneralAddsDatamodel({
    this.status,
    this.data,
    this.errorMessage,
  });

  bool status;
  List<Datum> data;
  dynamic errorMessage;

  factory GeneralAddsDatamodel.fromJson(Map<String, dynamic> json) =>
      GeneralAddsDatamodel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.url,
    this.startDate,
    this.endDate,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String title;
  String url;
  DateTime startDate;
  DateTime endDate;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "startDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
