// To parse this JSON data, do
//
//     final forumDetailDataModel = forumDetailDataModelFromJson(jsonString);

import 'dart:convert';

ForumDetailDataModel forumDetailDataModelFromJson(str) =>
    ForumDetailDataModel.fromJson(str);

String forumDetailDataModelToJson(ForumDetailDataModel data) =>
    json.encode(data.toJson());

class ForumDetailDataModel {
  ForumDetailDataModel({
    this.flag,
    this.msg,
    this.data,
  });

  int flag;
  String msg;
  Data data;

  factory ForumDetailDataModel.fromJson(Map<String, dynamic> json) =>
      ForumDetailDataModel(
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
    this.forumId,
    this.userId,
    this.forumTopic,
    this.forumTitle,
    this.description,
    this.date,
    this.forumComments,
  });

  String forumId;
  String userId;
  String forumTopic;
  String forumTitle;
  String description;
  String date;
  List<ForumComment> forumComments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        forumId: json["forum_id"] == null ? null : json["forum_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        forumTopic: json["forum_topic"] == null ? null : json["forum_topic"],
        forumTitle: json["forum_title"] == null ? null : json["forum_title"],
        description: json["description"] == null ? null : json["description"],
        date: json["date"] == null ? null : json["date"],
        forumComments: json["forum_comments"] == null
            ? null
            : List<ForumComment>.from(
                json["forum_comments"].map((x) => ForumComment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "forum_id": forumId == null ? null : forumId,
        "user_id": userId == null ? null : userId,
        "forum_topic": forumTopic == null ? null : forumTopic,
        "forum_title": forumTitle == null ? null : forumTitle,
        "description": description == null ? null : description,
        "date": date == null ? null : date,
        "forum_comments": forumComments == null
            ? null
            : List<dynamic>.from(forumComments.map((x) => x.toJson())),
      };
}

class ForumComment {
  ForumComment({
    this.commentId,
    this.userId,
    this.commentText,
    this.username,
    this.profileImage,
    this.dateAdded,
  });

  String commentId;
  String userId;
  String commentText;
  String username;
  String profileImage;
  String dateAdded;

  factory ForumComment.fromJson(Map<String, dynamic> json) => ForumComment(
        commentId: json["comment_id"] == null ? null : json["comment_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        commentText: json["comment_text"] == null ? null : json["comment_text"],
        username: json["username"] == null ? null : json["username"],
        profileImage:
            json["profile_image"] == null ? null : json["profile_image"],
        dateAdded: json["date_added"] == null ? null : json["date_added"],
      );

  Map<String, dynamic> toJson() => {
        "comment_id": commentId == null ? null : commentId,
        "user_id": userId == null ? null : userId,
        "comment_text": commentText == null ? null : commentText,
        "username": username == null ? null : username,
        "profile_image": profileImage == null ? null : profileImage,
        "date_added": dateAdded == null ? null : dateAdded,
      };
}
