// To parse this JSON data, do
//
//     final addForumDataModel = addForumDataModelFromJson(jsonString);

import 'dart:convert';

AddForumDataModel addForumDataModelFromJson(str) =>
    AddForumDataModel.fromJson(str);

String addForumDataModelToJson(AddForumDataModel data) =>
    json.encode(data.toJson());

class AddForumDataModel {
  AddForumDataModel({
    this.flag,
    this.msg,
    this.accessToken,
    this.data,
  });

  int flag;
  String msg;
  String accessToken;
  Data data;

  factory AddForumDataModel.fromJson(Map<String, dynamic> json) =>
      AddForumDataModel(
        flag: json["flag"] == null ? null : json["flag"],
        msg: json["msg"] == null ? null : json["msg"],
        accessToken: json["access_token"] == null ? null : json["access_token"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag == null ? null : flag,
        "msg": msg == null ? null : msg,
        "access_token": accessToken == null ? null : accessToken,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.forumId,
    this.forumTopic,
    this.forumTitle,
    this.description,
    this.isFlag,
  });

  String forumId;
  String forumTopic;
  String forumTitle;
  String description;
  String isFlag;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        forumId: json["forum_id"] == null ? null : json["forum_id"],
        forumTopic: json["forum_topic"] == null ? null : json["forum_topic"],
        forumTitle: json["forum_title"] == null ? null : json["forum_title"],
        description: json["description"] == null ? null : json["description"],
        isFlag: json["is_flag"] == null ? null : json["is_flag"],
      );

  Map<String, dynamic> toJson() => {
        "forum_id": forumId == null ? null : forumId,
        "forum_topic": forumTopic == null ? null : forumTopic,
        "forum_title": forumTitle == null ? null : forumTitle,
        "description": description == null ? null : description,
        "is_flag": isFlag == null ? null : isFlag,
      };
}
