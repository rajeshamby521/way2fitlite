import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/compare/data/dataModel/compare_model.dart';
import 'package:way2fitlife/features/compare/data/dataModel/set_compare_data_model.dart';
import 'package:way2fitlife/features/compare/data/dataSource/compare_datasource.dart';
import 'package:way2fitlife/features/compare/domain/repository/compare_repository.dart';

class CompareRepositoryImpl extends CompareRepository {
  CompareDataSource compareDataSource;

  CompareRepositoryImpl({this.compareDataSource});

  @override
  Future<Either<Failure, ComparePhotoDataModel>> getComparePhotoData({int offSet}) async {
    final result = await compareDataSource.getComparePhotoData(offSet: offSet);
    return Right(result);
  }

  @override
  Future<Either<Failure, DateModel>> getDate({DateTime dateTime, int pic}) async {
    final result = await compareDataSource.getDate(dateTime: dateTime, pic: pic);
    return Right(result);
  }

  @override
  Future<Either<Failure, ImageModel>> getPhoto({File image, int pic}) async {
    final result = await compareDataSource.getPhoto(image: image, pic: pic);
    return Right(result);
  }

  @override
  Future<Either<Failure, WeightModel>> getWeight({double weight, int pic}) async {
    final result = await compareDataSource.getWeight(weight: weight, pic: pic);
    return Right(result);
  }

  @override
  Future<Either<Failure, SetComparePhotoDataModel>> setCompareDate({
    File beforePhoto,
    File afterPhoto,
    String beforeWeight,
    String afterWeight,
    String beforeDate,
    String afterDate,
  }) async {
    final result = await compareDataSource.setComparePhotoData(
      beforePhoto: beforePhoto,
      afterPhoto: afterPhoto,
      beforeDate: beforeDate,
      afterDate: afterDate,
      beforeWeight: beforeWeight,
      afterWeight: afterWeight,
    );
    return Right(result);
  }
}
