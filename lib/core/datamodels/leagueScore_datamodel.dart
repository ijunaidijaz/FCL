// To parse this JSON data, do
//
//     final leagueScoreDatamodel = leagueScoreDatamodelFromJson(jsonString);

import 'dart:convert';

LeagueScoreDatamodel leagueScoreDatamodelFromJson(String str) =>
    LeagueScoreDatamodel.fromJson(json.decode(str));

String leagueScoreDatamodelToJson(LeagueScoreDatamodel data) =>
    json.encode(data.toJson());

class LeagueScoreDatamodel {
  LeagueScoreDatamodel({
    this.status,
    this.data,
    this.errorMessage,
  });

  bool status;
  Data data;
  String errorMessage;

  factory LeagueScoreDatamodel.fromJson(Map<String, dynamic> json) =>
      LeagueScoreDatamodel(
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
  List<LeagueData> data;
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
        data: List<LeagueData>.from(
            json["data"].map((x) => LeagueData.fromJson(x))),
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

class LeagueData {
  LeagueData({
    this.id,
    this.competitionId,
    this.userId,
    this.transactionId,
    this.expireAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.overAllTotal,
    this.currentWeekScore,
    this.user,
  });

  int id;
  int competitionId;
  int userId;
  int transactionId;
  DateTime expireAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int overAllTotal;
  int currentWeekScore;
  User user;

  factory LeagueData.fromJson(Map<String, dynamic> json) => LeagueData(
        id: json["id"],
        competitionId: json["competition_id"],
        userId: json["user_id"],
        transactionId: json["transaction_id"],
        expireAt: DateTime.parse(json["expireAt"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        overAllTotal: json["overAllTotal"],
        currentWeekScore: json["currentWeekScore"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "competition_id": competitionId,
        "user_id": userId,
        "transaction_id": transactionId,
        "expireAt":
            "${expireAt.year.toString().padLeft(4, '0')}-${expireAt.month.toString().padLeft(2, '0')}-${expireAt.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "overAllTotal": overAllTotal,
        "currentWeekScore": currentWeekScore,
        "user": user.toJson(),
      };
}

class User {
  User({
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
  String countryCode;
  dynamic image;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fName: json["f_name"],
        lName: json["l_name"],
        dob: DateTime.parse(json["dob"]),
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        countryCode: json["countryCode"] == null ? null : json["countryCode"],
        image: json["image"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "l_name": lName,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "email": email,
        "username": username,
        "phone": phone,
        "countryCode": countryCode == null ? null : countryCode,
        "image": image,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
