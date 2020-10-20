import 'package:way2fitlife/features/food_instructions/data/datamodel/food_instruction_datamodel.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FoodInstructionState {}

class LoadingBeginFoodInstructionState extends FoodInstructionState {}

class InitialFoodInstructionState extends FoodInstructionState {}

class LoadingEndFoodInstructionState extends FoodInstructionState {}

class ErrorState extends FoodInstructionState {
  final String message;

  ErrorState(this.message);
}

class GetFoodInstructionDataState extends FoodInstructionState {
  FoodInstructionDataModel data;

  GetFoodInstructionDataState({this.data});
}
