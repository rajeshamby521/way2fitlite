import 'package:way2fitlife/features/weight_sheet/data/datamodel/weight_sheet_model.dart';
import 'package:way2fitlife/features/weight_sheet/data/datasource/weight_sheet_datasource_impl.dart';

abstract class WeightSheetEvent {}

class GetWeightSheetEvent extends WeightSheetEvent {
  int offSet;

  GetWeightSheetEvent({this.offSet});
}
class GetWeightSheetNextPageEvent extends WeightSheetEvent {
  int offSet;

  GetWeightSheetNextPageEvent({this.offSet});
}

class SetWeightSheetEvent extends WeightSheetEvent {
  String date;
  String weight;

  SetWeightSheetEvent({this.date, this.weight});
}

class GetWeightEvent extends WeightSheetEvent {
  double weight;

  GetWeightEvent({this.weight});
}

class GetDateEvent extends WeightSheetEvent {
  DateTime dateTime;

  GetDateEvent({this.dateTime});
}
