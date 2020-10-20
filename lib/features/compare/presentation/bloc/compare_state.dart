import 'package:way2fitlife/features/compare/data/dataModel/compare_model.dart';
import 'package:way2fitlife/features/compare/data/dataModel/set_compare_data_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CompareState {}

class InitialCompareState extends CompareState {}

class LoadingBeginHomeState extends CompareState {}

class LoadingEndHomeState extends CompareState {}

class LoadingBeginNextPageState extends CompareState {}

class LoadingEndNextPageState extends CompareState {}

class ErrorState extends CompareState {
  final String message;

  ErrorState(this.message);
}

class GetComparePhotoDataState extends CompareState {
  final ComparePhotoDataModel data;

  GetComparePhotoDataState({this.data});
}

class GetComparePhotoNextPageDataState extends CompareState {
  final ComparePhotoDataModel data;

  GetComparePhotoNextPageDataState({this.data});
}

class SetComparePhotoDataState extends CompareState {
  final SetComparePhotoDataModel data;

  SetComparePhotoDataState({this.data});
}

class GetComparePhotoState extends CompareState {
  final ImageModel imageModel;

  GetComparePhotoState({this.imageModel});
}

class GetCompareWeightState extends CompareState {
  final WeightModel weightModel;

  GetCompareWeightState({this.weightModel});
}

class GetCompareDateState extends CompareState {
  final DateModel dateTimeModel;

  GetCompareDateState({this.dateTimeModel});
}
