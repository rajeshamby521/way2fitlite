import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/food_instructions/data/datamodel/food_instruction_datamodel.dart';
import 'package:way2fitlife/features/food_instructions/domain/repository/food_instruction_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';

class FoodInstructionUseCase extends UseCase<FoodInstructionDataModel, FoodInstructionDataParams> {
  FoodInstructionRepository foodInstructionRepository;

  FoodInstructionUseCase({this.foodInstructionRepository});

  @override
  Future<Either<Failure, FoodInstructionDataModel>> call(FoodInstructionDataParams params) async =>
      await foodInstructionRepository.getFoodInstructionData(foodAvoidId: params.foodAvoidId);
}

class FoodInstructionDataParams extends Equatable {
  final String foodAvoidId;

  FoodInstructionDataParams({this.foodAvoidId});

  @override
  List<Object> get props => [foodAvoidId];
}
