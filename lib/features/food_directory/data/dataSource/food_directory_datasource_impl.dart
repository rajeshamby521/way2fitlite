import 'package:dio/dio.dart';
import 'package:way2fitlife/features/food_directory/data/dataModel/food_directory_model.dart';
import 'package:way2fitlife/features/food_directory/data/dataSource/food_directory_datasource.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference.dart';

class FoodDirectoryDataSourceImpl extends FoodDirectoryDataSource {
  FoodCategoryModel data;
  Dio _dio = Dio(options);

  @override
  Future<FoodCategoryModel> fetchFoodDirectoryData() async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreference.getString(user_id);
    map[access_token] = AppPreference.getString(access_token);
    map[lang] = "0";

    var response = await _dio.post(getFoodCategoryListURL, data: FormData.fromMap(map));
    data = FoodCategoryModel.fromMap(response.data);
    return data;
  }
}
