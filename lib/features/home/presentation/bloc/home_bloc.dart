import 'package:way2fitlife/features/home/domain/usecases/home_usecase.dart';
import 'package:way2fitlife/features/home/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeUseCase homeUseCase;

  HomeBloc({@required this.homeUseCase}) : super(InitialHomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is FetchHomeDataEvent) {
      yield LoadingBeginHomeState();
      final result = await homeUseCase(HomeDataParams());
      yield LoadingEndHomeState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => FetchHomeDataState(modelData: success),
      );
    }
  }
}
