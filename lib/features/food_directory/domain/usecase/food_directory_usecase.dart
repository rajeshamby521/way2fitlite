import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/food_directory/data/dataModel/food_directory_model.dart';
import 'package:way2fitlife/features/food_directory/domain/repository/food_directory_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';

class FoodDirectoryUseCase extends UseCase<FoodCategoryModel, FoodDirectoryDataParams> {
  FoodDirectoryRepository foodDirectoryRepository;

  FoodDirectoryUseCase({this.foodDirectoryRepository});

  @override
  Future<Either<Failure, FoodCategoryModel>> call(FoodDirectoryDataParams params) async {
    return await foodDirectoryRepository.getFoodDirectoryData();
  }
}

class FoodDirectoryDataParams extends Equatable {
  FoodDirectoryDataParams();

  @override
  List<Object> get props => [];
}
