import 'package:dio/dio.dart';
import 'package:way2fitlife/features/food_instructions/data/datamodel/food_instruction_datamodel.dart';
import 'package:way2fitlife/features/food_instructions/data/datasource/food_instruction_datasource.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference.dart';

class FoodInstructionDataSourceImpl extends FoodInstructionDataSource {
  Dio _dio = Dio(options);
  FoodInstructionDataModel data;

  @override
  Future<FoodInstructionDataModel> getFoodInstructionData({String foodAvoidId}) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreference.getString(user_id);
    map[access_token] = AppPreference.getString(access_token);
    map[lang] = "0";
    map[food_avoid_id] = foodAvoidId;

    var response = await _dio.post(getFoodInstructionURL, data: FormData.fromMap(map));
    data = FoodInstructionDataModel.fromMap(response.data);
    return data;
  }
}
