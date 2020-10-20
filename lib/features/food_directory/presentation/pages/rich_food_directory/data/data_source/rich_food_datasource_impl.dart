import 'package:dio/dio.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_model/rich_food_detail_model.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_model/rich_food_model.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_source/rich_food_datasource.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference.dart';

class RichFoodDataSourceImpl extends RichFoodDataSource {
  Dio _dio = Dio(options);
  RichFoodDataModel richFoodData;
  RichFoodDetailDataModel richFoodDetailData;

  @override
  Future<RichFoodDataModel> fetchRichFoodData({String categoryId, String offSet}) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreference.getString(user_id);
    map[access_token] = AppPreference.getString(access_token);
    map[lang] = "0";
    map[category_id] = categoryId;
    map[offSet] = offSet;

    var responce = await _dio.post(getFoodDirectoryListURL, data: FormData.fromMap(map));
    richFoodData = RichFoodDataModel.fromMap(responce.data);
    return richFoodData;
  }

  @override
  Future<RichFoodDetailDataModel> fetchRichFoodDetailData({String foodId}) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreference.getString(user_id);
    map[access_token] = AppPreference.getString(access_token);
    map[lang] = "0";
    map[food_id] = foodId;

    var responce = await _dio.post(getFoodDetailURL, data: FormData.fromMap(map));
    richFoodDetailData = RichFoodDetailDataModel.fromMap(responce.data);
    return richFoodDetailData;
  }
}
