import 'package:way2fitlife/features/food_instructions/domain/usecase/food_instruction_usecase.dart';
import 'package:way2fitlife/features/food_instructions/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodInstructionBloc extends Bloc<FoodInstructionEvent, FoodInstructionState> {
  FoodInstructionUseCase foodInstructionUseCase;

  FoodInstructionBloc({this.foodInstructionUseCase}) : super(InitialFoodInstructionState());

  @override
  Stream<FoodInstructionState> mapEventToState(FoodInstructionEvent event) async* {
    if (event is GetFoodInstructionDataEvent) {
      yield LoadingBeginFoodInstructionState();
      final result =
          await foodInstructionUseCase(FoodInstructionDataParams(foodAvoidId: event.foodAvoidId));
      yield LoadingEndFoodInstructionState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetFoodInstructionDataState(data: success),
      );
    }
  }
}
