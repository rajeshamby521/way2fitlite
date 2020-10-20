import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_model/rich_food_detail_model.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_model/rich_food_model.dart';

abstract class RichFoodDataSource {
  Future<RichFoodDataModel> fetchRichFoodData({String categoryId, String offSet});
  Future<RichFoodDetailDataModel> fetchRichFoodDetailData({String foodId});
}
