import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/current_bmr/domain/repository/current_bmr_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';

class CalculateBMRUseCase extends UseCase<double, CalculateBMRParams> {
  CurrentBMRRepository currentBMRRepository;

  CalculateBMRUseCase({this.currentBMRRepository});

  @override
  Future<Either<Failure, double>> call(CalculateBMRParams params) async {
    return await currentBMRRepository.getBMRData(
        weight: params.weight, height: params.height, gender: params.gender, age: params.age);
  }
}

class CalculateBMRParams extends Equatable {
  final double age;
  final double weight;
  final double height;
  final bool gender;

  CalculateBMRParams({this.weight, this.height, this.gender, this.age});

  @override
  List<Object> get props => [weight, height, age, gender];
}

class CalculateCaloriesUseCase extends UseCase<double, CalculateCaloriesParams> {
  CurrentBMRRepository currentBMRRepository;

  CalculateCaloriesUseCase({this.currentBMRRepository});

  @override
  Future<Either<Failure, double>> call(CalculateCaloriesParams params) async =>
      await currentBMRRepository.getCaloriesData(activity: params.activity, bmr: params.bmr);
}

class CalculateCaloriesParams extends Equatable {
  final String activity;
  final double bmr;

  CalculateCaloriesParams({this.activity, this.bmr});

  @override
  List<Object> get props => [activity, bmr];
}

class SelectGenderUseCase extends UseCase<bool, SelectGenderParams> {
  CurrentBMRRepository currentBMRRepository;

  SelectGenderUseCase({this.currentBMRRepository});

  @override
  Future<Either<Failure, bool>> call(SelectGenderParams params) async =>
      await currentBMRRepository.selectGenderData(gender: params.gender);
}

class SelectGenderParams extends Equatable {
  final bool gender;

  SelectGenderParams({this.gender});

  @override
  List<Object> get props => [gender];
}

class SelectActivityUseCase extends UseCase<String, SelectActivityParams> {
  CurrentBMRRepository currentBMRRepository;

  SelectActivityUseCase({this.currentBMRRepository});

  @override
  Future<Either<Failure, String>> call(SelectActivityParams params) async =>
      await currentBMRRepository.selectActivityData(activity: params.activity);
}

class SelectActivityParams extends Equatable {
  final String activity;

  SelectActivityParams({this.activity});

  @override
  List<Object> get props => [activity];
}
