import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_model/rich_food_detail_model.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_model/rich_food_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RichFoodState {}

class InitialRichFoodState extends FetchRichFoodDataState {}

class LoadingBeginRichFoodState extends RichFoodState {}

class LoadingEndRichFoodState extends RichFoodState {}
class LoadingBeginRichFoodDetailState extends RichFoodState {}

class LoadingEndRichFoodDetailState extends RichFoodState {}

class ErrorState extends RichFoodState {
  final String message;

  ErrorState(this.message);
}

class FetchRichFoodDataState extends RichFoodState {
  RichFoodDataModel data;

  FetchRichFoodDataState({this.data});
}

class FetchRichFoodDetailDataState extends RichFoodState {
  RichFoodDetailDataModel data;

  FetchRichFoodDetailDataState({this.data});
}
