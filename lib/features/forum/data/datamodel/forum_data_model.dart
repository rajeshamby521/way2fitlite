// To parse this JSON data, do
//
//     final forumDataModel = forumDataModelFromJson(jsonString);

import 'dart:convert';

ForumDataModel forumDataModelFromJson(str) => ForumDataModel.fromJson(str);

String forumDataModelToJson(ForumDataModel data) => json.encode(data.toJson());

class ForumDataModel {
  ForumDataModel({
    this.nextOffset,
    this.flag,
    this.msg,
    this.data,
  });

  int nextOffset;
  int flag;
  String msg;
  List<Datum> data;

  factory ForumDataModel.fromJson(Map<String, dynamic> json) => ForumDataModel(
        nextOffset: json["next_offset"] == null ? null : json["next_offset"],
        flag: json["flag"] == null ? null : json["flag"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "next_offset": nextOffset == null ? null : nextOffset,
        "flag": flag == null ? null : flag,
        "msg": msg == null ? null : msg,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.forumId,
    this.forumTopic,
    this.forumTitle,
  });

  String forumId;
  String forumTopic;
  String forumTitle;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        forumId: json["forum_id"] == null ? null : json["forum_id"],
        forumTopic: json["forum_topic"] == null ? null : json["forum_topic"],
        forumTitle: json["forum_title"] == null ? null : json["forum_title"],
      );

  Map<String, dynamic> toJson() => {
        "forum_id": forumId == null ? null : forumId,
        "forum_topic": forumTopic == null ? null : forumTopic,
        "forum_title": forumTitle == null ? null : forumTitle,
      };
}
