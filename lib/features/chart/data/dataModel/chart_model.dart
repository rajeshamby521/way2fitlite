// To parse this JSON data, do
//
//     final chartModel = chartModelFromMap(jsonString);

import 'dart:convert';

ChartModel chartModelFromMap(String str) => ChartModel.fromMap(json.decode(str));

String chartModelToMap(ChartModel data) => json.encode(data.toMap());

class ChartModel {
  ChartModel({
    this.flag,
    this.msg,
    this.accessToken,
    this.monthName,
    this.data,
  });

  int flag;
  String msg;
  String accessToken;
  String monthName;
  List<Datum> data;

  factory ChartModel.fromMap(Map<String, dynamic> json) => ChartModel(
    flag: json["flag"] == null ? null : json["flag"],
    msg: json["msg"] == null ? null : json["msg"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
    monthName: json["month_name"] == null ? null : json["month_name"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "flag": flag == null ? null : flag,
    "msg": msg == null ? null : msg,
    "access_token": accessToken == null ? null : accessToken,
    "month_name": monthName == null ? null : monthName,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class Datum {
  Datum({
    this.month,
    this.weight,
  });

  dynamic month;
  String weight;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    month: json["month"] == null ? null : json["month"],
    weight: json["weight"] == null ? null : json["weight"],
  );

  Map<String, dynamic> toMap() => {
    "month": month == null ? null : month,
    "weight": weight == null ? null : weight,
  };
}
