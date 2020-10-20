import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_model/rich_food_detail_model.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_model/rich_food_model.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_source/rich_food_datasource.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/domain/repository/rich_food_repository.dart';

class RichFoodRepositoryImpl extends RichFoodRepository {
  RichFoodDataSource richFoodDataSource;

  RichFoodRepositoryImpl({this.richFoodDataSource});

  @override
  Future<Either<Failure, RichFoodDataModel>> getRichFoodData(
      {String categoryId, String offSet}) async {
    final result = await richFoodDataSource.fetchRichFoodData(
      categoryId: categoryId,
      offSet: offSet,
    );
    return Right(result);
  }

  @override
  Future<Either<Failure, RichFoodDetailDataModel>> getRichFoodDetailData({String foodId}) async {
    final result = await richFoodDataSource.fetchRichFoodDetailData(foodId: foodId);
    return Right(result);
  }
}
