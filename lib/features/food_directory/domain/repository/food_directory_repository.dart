import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/food_directory/data/dataModel/food_directory_model.dart';

abstract class FoodDirectoryRepository {
  Future<Either<Failure, FoodCategoryModel>> getFoodDirectoryData();
}
