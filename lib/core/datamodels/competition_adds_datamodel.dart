// To parse this JSON data, do
//
//     final competitionAddsDatamodel = competitionAddsDatamodelFromJson(jsonString);

import 'dart:convert';

CompetitionAddsDatamodel competitionAddsDatamodelFromJson(String str) => CompetitionAddsDatamodel.fromJson(json.decode(str));

String competitionAddsDatamodelToJson(CompetitionAddsDatamodel data) => json.encode(data.toJson());

class CompetitionAddsDatamodel {
    CompetitionAddsDatamodel({
        this.status,
        this.data,
        this.errorMessage,
    });

    bool status;
    List<Datum> data;
    dynamic errorMessage;

    factory CompetitionAddsDatamodel.fromJson(Map<String, dynamic> json) => CompetitionAddsDatamodel(
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
        this.competitionId,
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
    DateTime createdAt;
    DateTime updatedAt;
    List<String> pictures;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        competitionId: json["competition_id"],
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pictures": List<dynamic>.from(pictures.map((x) => x)),
    };
}
