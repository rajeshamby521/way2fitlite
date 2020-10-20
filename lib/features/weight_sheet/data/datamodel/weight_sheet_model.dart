// To parse this JSON data, do
//
//     final weightSheetModel = weightSheetModelFromMap(jsonString);

import 'dart:convert';

WeightSheetModel weightSheetModelFromMap(String str) => WeightSheetModel.fromMap(json.decode(str));

String weightSheetModelToMap(WeightSheetModel data) => json.encode(data.toMap());

class WeightSheetModel {
  WeightSheetModel({
    this.nextOffset,
    this.flag,
    this.msg,
    this.data,
  });

  int nextOffset;
  int flag;
  String msg;
  List<Datum> data;

  factory WeightSheetModel.fromMap(Map<String, dynamic> json) => WeightSheetModel(
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
    this.createDate,
    this.weightData,
  });

  String createDate;
  List<WeightDatum> weightData;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        createDate: json["create_date"] == null ? null : json["create_date"],
        weightData: json["weight_data"] == null
            ? null
            : List<WeightDatum>.from(json["weight_data"].map((x) => WeightDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "create_date": createDate == null ? null : createDate,
        "weight_data":
            weightData == null ? null : List<dynamic>.from(weightData.map((x) => x.toMap())),
      };
}

class WeightDatum {
  WeightDatum({
    this.weightId,
    this.date,
    this.day,
    this.weight,
  });

  String weightId;
  String date;
  String day;
  String weight;

  factory WeightDatum.fromMap(Map<String, dynamic> json) => WeightDatum(
        weightId: json["weight_id"] == null ? null : json["weight_id"],
        date: json["date"] == null ? null : json["date"],
        day: json["day"] == null ? null : json["day"],
        weight: json["weight"] == null ? null : json["weight"],
      );

  Map<String, dynamic> toMap() => {
        "weight_id": weightId == null ? null : weightId,
        "date": date == null ? null : date,
        "day": day == null ? null : day,
        "weight": weight == null ? null : weight,
      };
}
