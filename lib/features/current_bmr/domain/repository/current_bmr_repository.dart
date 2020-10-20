import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';

abstract class CurrentBMRRepository {
  Future<Either<Failure, double>> getBMRData(
      {double age, double weight, double height, bool gender});

  Future<Either<Failure, double>> getCaloriesData({String activity, double bmr});

  Future<Either<Failure, bool>> selectGenderData({bool gender});

  Future<Either<Failure, String>> selectActivityData({String activity});
}
