import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/food_instructions/data/datamodel/food_instruction_datamodel.dart';
import 'package:way2fitlife/features/food_instructions/data/datasource/food_instruction_datasource.dart';
import 'package:way2fitlife/features/food_instructions/domain/repository/food_instruction_repository.dart';

class FoodInstructionRepositoryImpl extends FoodInstructionRepository {
  FoodInstructionDataSource foodInstructionDataSource;

  FoodInstructionRepositoryImpl({this.foodInstructionDataSource});

  @override
  Future<Either<Failure, FoodInstructionDataModel>> getFoodInstructionData(
      {String foodAvoidId}) async {
    final result = await foodInstructionDataSource.getFoodInstructionData(foodAvoidId: foodAvoidId);
    return Right(result);
  }
}
