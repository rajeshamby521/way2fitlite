abstract class FoodInstructionEvent {}

class GetFoodInstructionDataEvent extends FoodInstructionEvent {
  String foodAvoidId;

  GetFoodInstructionDataEvent({this.foodAvoidId});
}
