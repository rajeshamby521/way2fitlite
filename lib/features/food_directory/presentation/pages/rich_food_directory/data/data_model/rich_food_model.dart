// To parse this JSON data, do
//
//     final richFoodDataModel = richFoodDataModelFromMap(jsonString);

import 'dart:convert';

RichFoodDataModel richFoodDataModelFromMap(String str) => RichFoodDataModel.fromMap(json.decode(str));

String richFoodDataModelToMap(RichFoodDataModel data) => json.encode(data.toMap());

class RichFoodDataModel {
  RichFoodDataModel({
    this.nextOffset,
    this.flag,
    this.msg,
    this.data,
  });

  int nextOffset;
  int flag;
  String msg;
  List<Datum> data;

  factory RichFoodDataModel.fromMap(Map<String, dynamic> json) => RichFoodDataModel(
    nextOffset: json["next_offset"] == null ? null : json["next_offset"],
    flag: json["flag"] == null ? null : json["flag"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
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
    this.foodId,
    this.foodTitle,
    this.servingSize,
    this.calories,
    this.totalFat,
    this.totalCarbohydrate,
    this.protein,
    this.foodImage,
  });

  String foodId;
  String foodTitle;
  String servingSize;
  String calories;
  String totalFat;
  String totalCarbohydrate;
  String protein;
  String foodImage;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    foodId: json["food_id"] == null ? null : json["food_id"],
    foodTitle: json["food_title"] == null ? null : json["food_title"],
    servingSize: json["serving_size"] == null ? null : json["serving_size"],
    calories: json["calories"] == null ? null : json["calories"],
    totalFat: json["total_fat"] == null ? null : json["total_fat"],
    totalCarbohydrate: json["total_carbohydrate"] == null ? null : json["total_carbohydrate"],
    protein: json["protein"] == null ? null : json["protein"],
    foodImage: json["food_image"] == null ? null : json["food_image"],
  );

  Map<String, dynamic> toMap() => {
    "food_id": foodId == null ? null : foodId,
    "food_title": foodTitle == null ? null : foodTitle,
    "serving_size": servingSize == null ? null : servingSize,
    "calories": calories == null ? null : calories,
    "total_fat": totalFat == null ? null : totalFat,
    "total_carbohydrate": totalCarbohydrate == null ? null : totalCarbohydrate,
    "protein": protein == null ? null : protein,
    "food_image": foodImage == null ? null : foodImage,
  };
}
