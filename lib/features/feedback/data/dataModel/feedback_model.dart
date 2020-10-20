// To parse this JSON data, do
//
//     final feedBackModel = feedBackModelFromMap(jsonString);

import 'dart:convert';

FeedbackModel FeedbackModelFromMap(String str) => FeedbackModel.fromMap(json.decode(str));

String FeedbackModelToMap(FeedbackModel data) => json.encode(data.toMap());

class FeedbackModel {
  FeedbackModel({
    this.flag,
    this.msg,
  });

  int flag;
  String msg;

  factory FeedbackModel.fromMap(Map<String, dynamic> json) => FeedbackModel(
    flag: json["flag"] == null ? null : json["flag"],
    msg: json["msg"] == null ? null : json["msg"],
  );

  Map<String, dynamic> toMap() => {
    "flag": flag == null ? null : flag,
    "msg": msg == null ? null : msg,
  };
}

/// Error Model for Button Status
class ErrorStatusModel {
  bool buttonStatus;
  String msgMsg;
  String subMsg;

  ErrorStatusModel({this.buttonStatus, this.subMsg, this.msgMsg});
}