// To parse this JSON data, do
//
//     final photoGalleryModel = photoGalleryModelFromMap(jsonString);

import 'dart:convert';

PhotoGalleryModel photoGalleryModelFromMap(String str) => PhotoGalleryModel.fromMap(json.decode(str));

String photoGalleryModelToMap(PhotoGalleryModel data) => json.encode(data.toMap());

class PhotoGalleryModel {
  PhotoGalleryModel({
    this.nextOffset,
    this.flag,
    this.msg,
    this.data,
  });

  int nextOffset;
  int flag;
  String msg;
  List<Datum> data;

  factory PhotoGalleryModel.fromMap(Map<String, dynamic> json) => PhotoGalleryModel(
    nextOffset: json["next_offset"] == null ? null : json["next_offset"],
    flag: json["flag"] == null ? null : json["flag"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "next_offset": nextOffset == null ? null : nextOffset,
    "flag": flag == null ? null : flag,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class Datum {
  Datum({
    this.userPhotoId,
    this.date,
    this.weight,
    this.userPhoto,
  });

  String userPhotoId;
  String date;
  String weight;
  String userPhoto;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    userPhotoId: json["user_photo_id"] == null ? null : json["user_photo_id"],
    date: json["date"] == null ? null : json["date"],
    weight: json["weight"] == null ? null : json["weight"],
    userPhoto: json["user_photo"] == null ? null : json["user_photo"],
  );

  Map<String, dynamic> toMap() => {
    "user_photo_id": userPhotoId == null ? null : userPhotoId,
    "date": date == null ? null : date,
    "weight": weight == null ? null : weight,
    "user_photo": userPhoto == null ? null : userPhoto,
  };
}
