// To parse this JSON data, do
//
//     final addCommnetModel = addCommnetModelFromJson(jsonString);

import 'dart:convert';

AddCommnetModel addCommnetModelFromJson(str) => AddCommnetModel.fromJson(str);

String addCommnetModelToJson(AddCommnetModel data) =>
    json.encode(data.toJson());

class AddCommnetModel {
  AddCommnetModel({
    this.flag,
    this.msg,
    this.data,
  });

  int flag;
  String msg;
  Data data;

  factory AddCommnetModel.fromJson(Map<String, dynamic> json) =>
      AddCommnetModel(
        flag: json["flag"] == null ? null : json["flag"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag == null ? null : flag,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.commentId,
  });

  int commentId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        commentId: json["comment_id"] == null ? null : json["comment_id"],
      );

  Map<String, dynamic> toJson() => {
        "comment_id": commentId == null ? null : commentId,
      };
}
