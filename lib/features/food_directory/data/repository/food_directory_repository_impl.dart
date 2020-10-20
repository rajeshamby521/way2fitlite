import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/food_directory/data/dataModel/food_directory_model.dart';
import 'package:way2fitlife/features/food_directory/data/dataSource/food_directory_datasource.dart';
import 'package:way2fitlife/features/food_directory/domain/repository/food_directory_repository.dart';

class FoodDirectoryRepositoryImpl extends FoodDirectoryRepository {
  FoodDirectoryDataSource foodDirectoryDataSource;

  FoodDirectoryRepositoryImpl({this.foodDirectoryDataSource});

  @override
  Future<Either<Failure, FoodCategoryModel>> getFoodDirectoryData() async {
    final result = await foodDirectoryDataSource.fetchFoodDirectoryData();
    return Right(result);
  }
}
