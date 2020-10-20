import 'package:way2fitlife/features/current_bmr/domain/usecase/current_bmr_usecase.dart';
import 'package:way2fitlife/features/current_bmr/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentBMRBloc extends Bloc<CurrentBMREvent, CurrentBMRState> {
  CalculateBMRUseCase calculateBMRUseCase;
  CalculateCaloriesUseCase calculateCaloriesUseCase;
  SelectGenderUseCase selectGenderUseCase;
  SelectActivityUseCase selectActivityUseCase;

  CurrentBMRBloc({
    this.calculateBMRUseCase,
    this.calculateCaloriesUseCase,
    this.selectGenderUseCase,
    this.selectActivityUseCase,
  }) : super(InitialCurrentBMRState());

  @override
  Stream<CurrentBMRState> mapEventToState(CurrentBMREvent event) async* {
    if (event is CalculateBMREvent) {
      final result = await calculateBMRUseCase(CalculateBMRParams(
        weight: event.weight,
        height: event.height,
        gender: event.gender,
        age: event.age,
      ));
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => CalculateBMRState(bmr: success),
      );
    }
    if (event is CalculateCaloriesEvent) {
      final result = await calculateCaloriesUseCase(
          CalculateCaloriesParams(activity: event.activity, bmr: event.bmr));
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => CalculateCaloriesState(calories: success),
      );
    }
    if (event is SelectGenderEvent) {
      final result = await selectGenderUseCase(SelectGenderParams(gender: event.gender));
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => SelectGenderState(gender: success),
      );
    }
    if (event is SelectActivityEvent) {
      final result = await selectActivityUseCase(SelectActivityParams(activity: event.activity));
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => SelectActivityState(activity: success),
      );
    }
  }
}
