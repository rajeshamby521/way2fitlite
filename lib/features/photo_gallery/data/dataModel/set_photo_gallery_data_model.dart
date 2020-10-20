// To parse this JSON data, do
//
//     final setPhotoGalleryDataModel = setPhotoGalleryDataModelFromMap(jsonString);

import 'dart:convert';

SetPhotoGalleryDataModel setPhotoGalleryDataModelFromMap(String str) => SetPhotoGalleryDataModel.fromMap(json.decode(str));

String setPhotoGalleryDataModelToMap(SetPhotoGalleryDataModel data) => json.encode(data.toMap());

class SetPhotoGalleryDataModel {
  SetPhotoGalleryDataModel({
    this.flag,
    this.msg,
    this.accessToken,
    this.data,
  });

  int flag;
  String msg;
  String accessToken;
  Data data;

  factory SetPhotoGalleryDataModel.fromMap(Map<String, dynamic> json) => SetPhotoGalleryDataModel(
    flag: json["flag"] == null ? null : json["flag"],
    msg: json["msg"] == null ? null : json["msg"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "flag": flag == null ? null : flag,
    "msg": msg == null ? null : msg,
    "access_token": accessToken == null ? null : accessToken,
    "data": data == null ? null : data.toMap(),
  };
}

class Data {
  Data({
    this.userPhotoId,
    this.date,
    this.weight,
    this.userPhoto,
  });

  String userPhotoId;
  DateTime date;
  String weight;
  String userPhoto;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    userPhotoId: json["user_photo_id"] == null ? null : json["user_photo_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    weight: json["weight"] == null ? null : json["weight"],
    userPhoto: json["user_photo"] == null ? null : json["user_photo"],
  );

  Map<String, dynamic> toMap() => {
    "user_photo_id": userPhotoId == null ? null : userPhotoId,
    "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "weight": weight == null ? null : weight,
    "user_photo": userPhoto == null ? null : userPhoto,
  };
}
