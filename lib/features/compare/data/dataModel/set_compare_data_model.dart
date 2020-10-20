// To parse this JSON data, do
//
//     final setComparePhotoDataModel = setComparePhotoDataModelFromMap(jsonString);

import 'dart:convert';

SetComparePhotoDataModel setComparePhotoDataModelFromMap(String str) => SetComparePhotoDataModel.fromMap(json.decode(str));

String setComparePhotoDataModelToMap(SetComparePhotoDataModel data) => json.encode(data.toMap());

class SetComparePhotoDataModel {
  SetComparePhotoDataModel({
    this.flag,
    this.msg,
    this.accessToken,
    this.data,
  });

  int flag;
  String msg;
  String accessToken;
  List<Datum2> data;

  factory SetComparePhotoDataModel.fromMap(Map<String, dynamic> json) => SetComparePhotoDataModel(
    flag: json["flag"] == null ? null : json["flag"],
    msg: json["msg"] == null ? null : json["msg"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
    data: json["data"] == null ? null : List<Datum2>.from(json["data"].map((x) => Datum2.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "flag": flag == null ? null : flag,
    "msg": msg == null ? null : msg,
    "access_token": accessToken == null ? null : accessToken,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class Datum2 {
  Datum2({
    this.userComparePhotoId,
    this.beforeDate,
    this.beforeWeight,
    this.userBeforePhoto,
    this.afterDate,
    this.afterWeight,
    this.userAfterPhoto,
  });

  String userComparePhotoId;
  String beforeDate;
  String beforeWeight;
  String userBeforePhoto;
  String afterDate;
  String afterWeight;
  String userAfterPhoto;

  factory Datum2.fromMap(Map<String, dynamic> json) => Datum2(
    userComparePhotoId: json["user_compare_photo_id"] == null ? null : json["user_compare_photo_id"],
    beforeDate: json["before_date"] == null ? null : json["before_date"],
    beforeWeight: json["before_weight"] == null ? null : json["before_weight"],
    userBeforePhoto: json["user_before_photo"] == null ? null : json["user_before_photo"],
    afterDate: json["after_date"] == null ? null : json["after_date"],
    afterWeight: json["after_weight"] == null ? null : json["after_weight"],
    userAfterPhoto: json["user_after_photo"] == null ? null : json["user_after_photo"],
  );

  Map<String, dynamic> toMap() => {
    "user_compare_photo_id": userComparePhotoId == null ? null : userComparePhotoId,
    "before_date": beforeDate == null ? null : beforeDate,
    "before_weight": beforeWeight == null ? null : beforeWeight,
    "user_before_photo": userBeforePhoto == null ? null : userBeforePhoto,
    "after_date": afterDate == null ? null : afterDate,
    "after_weight": afterWeight == null ? null : afterWeight,
    "user_after_photo": userAfterPhoto == null ? null : userAfterPhoto,
  };
}
