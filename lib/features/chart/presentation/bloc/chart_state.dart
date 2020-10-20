import 'package:way2fitlife/features/chart/data/dataModel/chart_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChartState {}

class InitialChartState extends ChartState {}

class LoadingBeginChartState extends ChartState {}

class LoadingEndChartState extends ChartState {}

class ErrorState extends ChartState {
  final String message;

  ErrorState(this.message);
}
class GetChartDataState extends ChartState{
  final ChartModel data;
  GetChartDataState({this.data});
}