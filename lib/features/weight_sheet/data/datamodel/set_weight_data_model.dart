// To parse this JSON data, do
//
//     final setWeightDataModel = setWeightDataModelFromMap(jsonString);

import 'dart:convert';

SetWeightDataModel setWeightDataModelFromMap(String str) => SetWeightDataModel.fromMap(json.decode(str));

String setWeightDataModelToMap(SetWeightDataModel data) => json.encode(data.toMap());

class SetWeightDataModel {
  SetWeightDataModel({
    this.flag,
    this.msg,
    this.accessToken,
    this.data,
  });

  int flag;
  String msg;
  String accessToken;
  Data data;

  factory SetWeightDataModel.fromMap(Map<String, dynamic> json) => SetWeightDataModel(
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
    this.weightId,
    this.date,
    this.weight,
  });

  String weightId;
  DateTime date;
  String weight;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    weightId: json["weight_id"] == null ? null : json["weight_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    weight: json["weight"] == null ? null : json["weight"],
  );

  Map<String, dynamic> toMap() => {
    "weight_id": weightId == null ? null : weightId,
    "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "weight": weight == null ? null : weight,
  };
}
