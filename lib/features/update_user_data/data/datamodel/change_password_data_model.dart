// To parse this JSON data, do
//
//     final changePasswordDataModel = changePasswordDataModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordDataModel changePasswordDataModelFromJson(str) =>
    ChangePasswordDataModel.fromJson(str);

String changePasswordDataModelToJson(ChangePasswordDataModel data) =>
    json.encode(data.toJson());

class ChangePasswordDataModel {
  ChangePasswordDataModel({
    this.flag,
    this.msg,
    this.accessToken,
  });

  int flag;
  String msg;
  String accessToken;

  factory ChangePasswordDataModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordDataModel(
        flag: json["flag"] == null ? null : json["flag"],
        msg: json["msg"] == null ? null : json["msg"],
        accessToken: json["access_token"] == null ? null : json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "flag": flag == null ? null : flag,
        "msg": msg == null ? null : msg,
        "access_token": accessToken == null ? null : accessToken,
      };
}
