import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/current_bmr/data/datasource/current_bmr_datasource.dart';
import 'package:way2fitlife/features/current_bmr/domain/repository/current_bmr_repository.dart';

class CurrentBMRRepositoryImpl extends CurrentBMRRepository {
  CurrentBMRDataSource currentBMRDataSource;

  CurrentBMRRepositoryImpl({this.currentBMRDataSource});

  @override
  Future<Either<Failure, double>> getCaloriesData({String activity, double bmr}) async {
    final result = await currentBMRDataSource.getCaloriesData(activity: activity, bmr: bmr);
    return Right(result);
  }

  @override
  Future<Either<Failure, bool>> selectGenderData({bool gender}) async {
    final result = await currentBMRDataSource.selectGenderData(gender: gender);
    return Right(result);
  }

  @override
  Future<Either<Failure, String>> selectActivityData({String activity}) async {
    final result = await currentBMRDataSource.selectActivityData(activity: activity);
    return Right(result);
  }

  @override
  Future<Either<Failure, double>> getBMRData(
      {double age, double weight, double height, bool gender}) async {
    final result = await currentBMRDataSource.getBMRData(
        age: age, gender: gender, height: height, weight: weight);
    return Right(result);
  }
}
