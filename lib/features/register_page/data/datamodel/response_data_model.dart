// To parse this JSON data, do
//
//     final responseDataModel = responseDataModelFromJson(jsonString);

import 'dart:convert';

ResponseDataModel responseDataModelFromJson(str) =>
    ResponseDataModel.fromJson(str);

String responseDataModelToJson(ResponseDataModel data) =>
    json.encode(data.toJson());

class ResponseDataModel {
  ResponseDataModel({
    this.flag,
    this.msg,
    this.data,
  });

  int flag;
  String msg;
  UserData data;

  factory ResponseDataModel.fromJson(Map<String, dynamic> json) =>
      ResponseDataModel(
        flag: json["flag"] == null ? null : json["flag"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag == null ? null : flag,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data.toJson(),
      };
}

class UserData {
  UserData({
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
  String dateModified;
  String isFlag;
  String profileImage;
  String accessToken;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
        dateModified:
            json["date_modified"] == null ? null : json["date_modified"],
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
        "date_modified": dateModified == null ? null : dateModified,
        "is_flag": isFlag == null ? null : isFlag,
        "profile_image": profileImage == null ? null : profileImage,
        "access_token": accessToken == null ? null : accessToken,
      };
}
