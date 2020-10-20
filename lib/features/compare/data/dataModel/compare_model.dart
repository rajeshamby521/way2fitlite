// To parse this JSON data, do
//
//     final comparePhotoDataModel = comparePhotoDataModelFromMap(jsonString);

import 'dart:convert';

import 'dart:io';

ComparePhotoDataModel comparePhotoDataModelFromMap(String str) =>
    ComparePhotoDataModel.fromMap(json.decode(str));

String comparePhotoDataModelToMap(ComparePhotoDataModel data) => json.encode(data.toMap());

class ComparePhotoDataModel {
  ComparePhotoDataModel({
    this.nextOffset,
    this.flag,
    this.msg,
    this.data,
  });

  int nextOffset;
  int flag;
  String msg;
  List<Datum> data;

  factory ComparePhotoDataModel.fromMap(Map<String, dynamic> json) => ComparePhotoDataModel(
        nextOffset: json["next_offset"] == null ? null : json["next_offset"],
        flag: json["flag"] == null ? null : json["flag"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
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

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        userComparePhotoId:
            json["user_compare_photo_id"] == null ? null : json["user_compare_photo_id"],
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

class DateModel {
  DateTime dateTime;
  int pic;

  DateModel({this.dateTime, this.pic});
}

class WeightModel {
  double weight;
  int pic;

  WeightModel({this.weight, this.pic});
}

class ImageModel {
  File image;
  int pic;

  ImageModel({this.image, this.pic});
}
