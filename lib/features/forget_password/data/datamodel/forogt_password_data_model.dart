
import 'dart:convert';

ForgotPasswordDataModel forgotPasswordDataModelFromJson(str) => ForgotPasswordDataModel.fromJson(str);

String forgotPasswordDataModelToJson(ForgotPasswordDataModel data) => json.encode(data.toJson());

class ForgotPasswordDataModel {
  ForgotPasswordDataModel({
    this.flag,
    this.msg,
  });

  int flag;
  String msg;

  factory ForgotPasswordDataModel.fromJson(Map<String, dynamic> json) => ForgotPasswordDataModel(
    flag: json["flag"] == null ? null : json["flag"],
    msg: json["msg"] == null ? null : json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "flag": flag == null ? null : flag,
    "msg": msg == null ? null : msg,
  };
}
