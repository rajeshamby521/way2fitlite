import 'package:way2fitlife/features/weight_sheet/data/datamodel/set_weight_data_model.dart';
import 'package:way2fitlife/features/weight_sheet/data/datamodel/weight_sheet_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeightSheetState {}

class InitialWeightSheetState extends WeightSheetState {}

class LoadingBeginHomeState extends WeightSheetState {}

class LoadingEndHomeState extends WeightSheetState {}

class LoadingBeginNextPageState extends WeightSheetState {}

class LoadingEndNextPageState extends WeightSheetState {}

class ErrorState extends WeightSheetState {
  final String message;

  ErrorState(this.message);
}

class GetWeightSheetState extends WeightSheetState {
  WeightSheetModel data;

  GetWeightSheetState({this.data});
}

class GetWeightSheetNextPageState extends WeightSheetState {
  WeightSheetModel data;

  GetWeightSheetNextPageState({this.data});
}

class SetWeightSheetState extends WeightSheetState {
  SetWeightDataModel data;

  SetWeightSheetState({this.data});
}

class GetWeightState extends WeightSheetState {
  double weight;

  GetWeightState({this.weight});
}

class GetDateState extends WeightSheetState {
  DateTime dateTime;

  GetDateState({this.dateTime});
}
