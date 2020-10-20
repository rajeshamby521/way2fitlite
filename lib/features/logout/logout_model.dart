// To parse this JSON data, do
//
//     final logOutModel = logOutModelFromMap(jsonString);

import 'dart:convert';

LogOutModel logOutModelFromMap(String str) => LogOutModel.fromMap(json.decode(str));

String logOutModelToMap(LogOutModel data) => json.encode(data.toMap());

class LogOutModel {
  LogOutModel({
    this.flag,
    this.msg,
  });

  int flag;
  String msg;

  factory LogOutModel.fromMap(Map<String, dynamic> json) => LogOutModel(
    flag: json["flag"] == null ? null : json["flag"],
    msg: json["msg"] == null ? null : json["msg"],
  );

  Map<String, dynamic> toMap() => {
    "flag": flag == null ? null : flag,
    "msg": msg == null ? null : msg,
  };
}
