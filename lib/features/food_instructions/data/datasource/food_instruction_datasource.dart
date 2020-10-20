import 'package:way2fitlife/features/food_instructions/data/datamodel/food_instruction_datamodel.dart';

abstract class FoodInstructionDataSource {
  Future<FoodInstructionDataModel> getFoodInstructionData({String foodAvoidId});
}
