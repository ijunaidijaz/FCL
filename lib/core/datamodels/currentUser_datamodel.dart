// To parse this JSON data, do
//
//     final currentUserDatamodel = currentUserDatamodelFromJson(jsonString);

import 'dart:convert';

CurrentUserDatamodel currentUserDatamodelFromJson(String str) =>
    CurrentUserDatamodel.fromJson(json.decode(str));

String currentUserDatamodelToJson(CurrentUserDatamodel data) =>
    json.encode(data.toJson());

class CurrentUserDatamodel {
  CurrentUserDatamodel({
    this.status,
    this.data,
    this.errorMessage,
  });

  bool status;
  Data data;
  dynamic errorMessage;

  factory CurrentUserDatamodel.fromJson(Map<String, dynamic> json) =>
      CurrentUserDatamodel(
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
    this.fName,
    this.lName,
    this.dob,
    this.email,
    this.username,
    this.phone,
    this.countryCode,
    this.image,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String fName;
  String lName;
  DateTime dob;
  String email;
  String username;
  String phone;
  dynamic countryCode;
  dynamic image;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        fName: json["f_name"],
        lName: json["l_name"],
        dob: DateTime.parse(json["dob"]),
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        countryCode: json["countryCode"],
        image: json["image"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "l_name": lName,
        "dob": dob.toIso8601String(),
        "email": email,
        "username": username,
        "phone": phone,
        "countryCode": countryCode,
        "image": image,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
