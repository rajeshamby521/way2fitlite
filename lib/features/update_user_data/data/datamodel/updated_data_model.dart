// To parse this JSON data, do
//
//     final updatedDataModel = updatedDataModelFromJson(jsonString);

import 'dart:convert';

UpdatedDataModel updatedDataModelFromJson(str) =>
    UpdatedDataModel.fromJson(str);

String updatedDataModelToJson(UpdatedDataModel data) =>
    json.encode(data.toJson());

class UpdatedDataModel {
  UpdatedDataModel({
    this.flag,
    this.msg,
    this.data,
  });

  int flag;
  String msg;
  Data data;

  factory UpdatedDataModel.fromJson(Map<String, dynamic> json) =>
      UpdatedDataModel(
        flag: json["flag"] == null ? null : json["flag"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag == null ? null : flag,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.userId,
    this.username,
    this.email,
    this.gender,
    this.height,
    this.weight,
    this.birthdate,
    this.mobile,
    this.activityType,
    this.dateAdded,
    this.dateModified,
    this.isFlag,
    this.profileImage,
    this.accessToken,
  });

  String userId;
  String username;
  String email;
  String gender;
  String height;
  String weight;
  DateTime birthdate;
  String mobile;
  String activityType;
  DateTime dateAdded;
  DateTime dateModified;
  String isFlag;
  String profileImage;
  String accessToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"] == null ? null : json["user_id"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        gender: json["gender"] == null ? null : json["gender"],
        height: json["height"] == null ? null : json["height"],
        weight: json["weight"] == null ? null : json["weight"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        mobile: json["mobile"] == null ? null : json["mobile"],
        activityType:
            json["activity_type"] == null ? null : json["activity_type"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        isFlag: json["is_flag"] == null ? null : json["is_flag"],
        profileImage:
            json["profile_image"] == null ? null : json["profile_image"],
        accessToken: json["access_token"] == null ? null : json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "gender": gender == null ? null : gender,
        "height": height == null ? null : height,
        "weight": weight == null ? null : weight,
        "birthdate": birthdate == null
            ? null
            : "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "mobile": mobile == null ? null : mobile,
        "activity_type": activityType == null ? null : activityType,
        "date_added": dateAdded == null ? null : dateAdded.toIso8601String(),
        "date_modified":
            dateModified == null ? null : dateModified.toIso8601String(),
        "is_flag": isFlag == null ? null : isFlag,
        "profile_image": profileImage == null ? null : profileImage,
        "access_token": accessToken == null ? null : accessToken,
      };
}
