// To parse this JSON data, do
//
//     final socialLinksDatamodel = socialLinksDatamodelFromJson(jsonString);

import 'dart:convert';

SocialLinksDatamodel socialLinksDatamodelFromJson(String str) => SocialLinksDatamodel.fromJson(json.decode(str));

String socialLinksDatamodelToJson(SocialLinksDatamodel data) => json.encode(data.toJson());

class SocialLinksDatamodel {
    SocialLinksDatamodel({
        this.status,
        this.data,
        this.errorMessage,
    });

    bool status;
    List<Datum> data;
    dynamic errorMessage;

    factory SocialLinksDatamodel.fromJson(Map<String, dynamic> json) => SocialLinksDatamodel(
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
        this.socialName,
        this.link,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String socialName;
    String link;
    DateTime createdAt;
    DateTime updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        socialName: json["socialName"],
        link: json["link"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "socialName": socialName,
        "link": link,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
