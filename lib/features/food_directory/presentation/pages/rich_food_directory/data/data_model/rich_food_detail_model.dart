// To parse this JSON data, do
//
//     final richFoodDetailDataModel = richFoodDetailDataModelFromMap(jsonString);

import 'dart:convert';

RichFoodDetailDataModel richFoodDetailDataModelFromMap(String str) => RichFoodDetailDataModel.fromMap(json.decode(str));

String richFoodDetailDataModelToMap(RichFoodDetailDataModel data) => json.encode(data.toMap());

class RichFoodDetailDataModel {
  RichFoodDetailDataModel({
    this.flag,
    this.msg,
    this.data,
  });

  int flag;
  String msg;
  Data data;

  factory RichFoodDetailDataModel.fromMap(Map<String, dynamic> json) => RichFoodDetailDataModel(
    flag: json["flag"] == null ? null : json["flag"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "flag": flag == null ? null : flag,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data.toMap(),
  };
}

class Data {
  Data({
    this.foodId,
    this.foodTitle,
    this.categoryName,
    this.serviceSize,
    this.calories,
    this.totalFat,
    this.saturatedFat,
    this.polyunsaturatedFat,
    this.monounsaturatedFat,
    this.transFat,
    this.cholesterol,
    this.sodium,
    this.potassium,
    this.totalCarbohydrate,
    this.dietaryFiber,
    this.sugar,
    this.protein,
    this.foodImage,
  });

  String foodId;
  String foodTitle;
  String categoryName;
  String serviceSize;
  String calories;
  String totalFat;
  String saturatedFat;
  String polyunsaturatedFat;
  String monounsaturatedFat;
  String transFat;
  String cholesterol;
  String sodium;
  String potassium;
  String totalCarbohydrate;
  String dietaryFiber;
  String sugar;
  String protein;
  String foodImage;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    foodId: json["food_id"] == null ? null : json["food_id"],
    foodTitle: json["food_title"] == null ? null : json["food_title"],
    categoryName: json["category_name"] == null ? null : json["category_name"],
    serviceSize: json["service_size"] == null ? null : json["service_size"],
    calories: json["calories"] == null ? null : json["calories"],
    totalFat: json["total_fat"] == null ? null : json["total_fat"],
    saturatedFat: json["saturated_fat"] == null ? null : json["saturated_fat"],
    polyunsaturatedFat: json["polyunsaturated_fat"] == null ? null : json["polyunsaturated_fat"],
    monounsaturatedFat: json["monounsaturated_fat"] == null ? null : json["monounsaturated_fat"],
    transFat: json["trans_fat"] == null ? null : json["trans_fat"],
    cholesterol: json["cholesterol"] == null ? null : json["cholesterol"],
    sodium: json["sodium"] == null ? null : json["sodium"],
    potassium: json["potassium"] == null ? null : json["potassium"],
    totalCarbohydrate: json["total_carbohydrate"] == null ? null : json["total_carbohydrate"],
    dietaryFiber: json["dietary_fiber"] == null ? null : json["dietary_fiber"],
    sugar: json["sugar"] == null ? null : json["sugar"],
    protein: json["protein"] == null ? null : json["protein"],
    foodImage: json["food_image"] == null ? null : json["food_image"],
  );

  Map<String, dynamic> toMap() => {
    "food_id": foodId == null ? null : foodId,
    "food_title": foodTitle == null ? null : foodTitle,
    "category_name": categoryName == null ? null : categoryName,
    "service_size": serviceSize == null ? null : serviceSize,
    "calories": calories == null ? null : calories,
    "total_fat": totalFat == null ? null : totalFat,
    "saturated_fat": saturatedFat == null ? null : saturatedFat,
    "polyunsaturated_fat": polyunsaturatedFat == null ? null : polyunsaturatedFat,
    "monounsaturated_fat": monounsaturatedFat == null ? null : monounsaturatedFat,
    "trans_fat": transFat == null ? null : transFat,
    "cholesterol": cholesterol == null ? null : cholesterol,
    "sodium": sodium == null ? null : sodium,
    "potassium": potassium == null ? null : potassium,
    "total_carbohydrate": totalCarbohydrate == null ? null : totalCarbohydrate,
    "dietary_fiber": dietaryFiber == null ? null : dietaryFiber,
    "sugar": sugar == null ? null : sugar,
    "protein": protein == null ? null : protein,
    "food_image": foodImage == null ? null : foodImage,
  };
}
