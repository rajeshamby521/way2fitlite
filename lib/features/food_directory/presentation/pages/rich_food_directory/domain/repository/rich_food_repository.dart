import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_model/rich_food_detail_model.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_model/rich_food_model.dart';

abstract class RichFoodRepository {
  Future<Either<Failure, RichFoodDataModel>> getRichFoodData({String categoryId, String offSet});
  Future<Either<Failure, RichFoodDetailDataModel>> getRichFoodDetailData({String foodId});
}
