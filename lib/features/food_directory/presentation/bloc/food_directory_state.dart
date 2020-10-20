import 'package:way2fitlife/features/food_directory/data/dataModel/food_directory_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FoodDirectoryState {}

class InitialFoodDirectoryState extends FetchFoodDirectoryDataState {}

class LoadingBeginHomeState extends FetchFoodDirectoryDataState {}

class LoadingEndHomeState extends FetchFoodDirectoryDataState {}

class ErrorState extends FetchFoodDirectoryDataState {
  final String message;

  ErrorState(this.message);
}
class FetchFoodDirectoryDataState extends FoodDirectoryState {
  FoodCategoryModel data;

  FetchFoodDirectoryDataState({this.data});
}
