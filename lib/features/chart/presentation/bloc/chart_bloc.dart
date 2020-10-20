import 'package:way2fitlife/features/chart/domain/usecase/chart_usecase.dart';
import 'package:way2fitlife/features/chart/presentation/bloc/chart_event.dart';
import 'package:way2fitlife/features/chart/presentation/bloc/chart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  ChartDataUseCase chartDataUseCase;

  ChartBloc({this.chartDataUseCase}) : super(InitialChartState());

  @override
  Stream<ChartState> mapEventToState(ChartEvent event) async* {
    if (event is GetChartDataEvent) {
      yield LoadingBeginChartState();
      final result = await chartDataUseCase(ChartDataParams(
        dateType: event.dateType,
        month: event.month,
      ));
      yield LoadingEndChartState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetChartDataState(data: success),
      );
    }
  }
}
