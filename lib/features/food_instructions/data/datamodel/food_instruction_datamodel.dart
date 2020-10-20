// To parse this JSON data, do
//
//     final foodInstructionDataModel = foodInstructionDataModelFromMap(jsonString);

import 'dart:convert';

FoodInstructionDataModel foodInstructionDataModelFromMap(String str) => FoodInstructionDataModel.fromMap(json.decode(str));

String foodInstructionDataModelToMap(FoodInstructionDataModel data) => json.encode(data.toMap());

class FoodInstructionDataModel {
  FoodInstructionDataModel({
    this.flag,
    this.msg,
    this.accessToken,
    this.data,
  });

  int flag;
  String msg;
  String accessToken;
  Data data;

  factory FoodInstructionDataModel.fromMap(Map<String, dynamic> json) => FoodInstructionDataModel(
    flag: json["flag"] == null ? null : json["flag"],
    msg: json["msg"] == null ? null : json["msg"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "flag": flag == null ? null : flag,
    "msg": msg == null ? null : msg,
    "access_token": accessToken == null ? null : accessToken,
    "data": data == null ? null : data.toMap(),
  };
}

class Data {
  Data({
    this.foodAvoidId,
    this.foodTitle,
    this.foodStrictlyText,
    this.foodEatText,
  });

  String foodAvoidId;
  String foodTitle;
  List<FoodStrictlyText> foodStrictlyText;
  List<FoodEatText> foodEatText;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    foodAvoidId: json["food_avoid_id"] == null ? null : json["food_avoid_id"],
    foodTitle: json["food_title"] == null ? null : json["food_title"],
    foodStrictlyText: json["food_strictly_text"] == null ? null : List<FoodStrictlyText>.from(json["food_strictly_text"].map((x) => FoodStrictlyText.fromMap(x))),
    foodEatText: json["food_eat_text"] == null ? null : List<FoodEatText>.from(json["food_eat_text"].map((x) => FoodEatText.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "food_avoid_id": foodAvoidId == null ? null : foodAvoidId,
    "food_title": foodTitle == null ? null : foodTitle,
    "food_strictly_text": foodStrictlyText == null ? null : List<dynamic>.from(foodStrictlyText.map((x) => x.toMap())),
    "food_eat_text": foodEatText == null ? null : List<dynamic>.from(foodEatText.map((x) => x.toMap())),
  };
}

class FoodEatText {
  FoodEatText({
    this.eat,
  });

  String eat;

  factory FoodEatText.fromMap(Map<String, dynamic> json) => FoodEatText(
    eat: json["eat"] == null ? null : json["eat"],
  );

  Map<String, dynamic> toMap() => {
    "eat": eat == null ? null : eat,
  };
}

class FoodStrictlyText {
  FoodStrictlyText({
    this.strictly,
  });

  String strictly;

  factory FoodStrictlyText.fromMap(Map<String, dynamic> json) => FoodStrictlyText(
    strictly: json["strictly"] == null ? null : json["strictly"],
  );

  Map<String, dynamic> toMap() => {
    "strictly": strictly == null ? null : strictly,
  };
}
