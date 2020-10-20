// To parse this JSON data, do
//
//     final FoodCategoryModel = FoodCategoryModelFromMap(jsonString);

import 'dart:convert';

FoodCategoryModel FoodCategoryModelFromMap(String str) => FoodCategoryModel.fromMap(json.decode(str));

String FoodCategoryModelToMap(FoodCategoryModel data) => json.encode(data.toMap());

class FoodCategoryModel {
  FoodCategoryModel({
    this.flag,
    this.msg,
    this.data,
  });

  int flag;
  String msg;
  List<Datum> data;

  factory FoodCategoryModel.fromMap(Map<String, dynamic> json) => FoodCategoryModel(
    flag: json["flag"] == null ? null : json["flag"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "flag": flag == null ? null : flag,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class Datum {
  Datum({
    this.categoryId,
    this.categoryName,
    this.categoryImage,
  });

  String categoryId;
  String categoryName;
  String categoryImage;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    categoryId: json["category_id"] == null ? null : json["category_id"],
    categoryName: json["category_name"] == null ? null : json["category_name"],
    categoryImage: json["category_image"] == null ? null : json["category_image"],
  );

  Map<String, dynamic> toMap() => {
    "category_id": categoryId == null ? null : categoryId,
    "category_name": categoryName == null ? null : categoryName,
    "category_image": categoryImage == null ? null : categoryImage,
  };
}
