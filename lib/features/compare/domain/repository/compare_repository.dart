import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/compare/data/dataModel/compare_model.dart';
import 'package:way2fitlife/features/compare/data/dataModel/set_compare_data_model.dart';

abstract class CompareRepository {
  Future<Either<Failure, SetComparePhotoDataModel>> setCompareDate({
    File beforePhoto,
    File afterPhoto,
    String beforeWeight,
    String afterWeight,
    String beforeDate,
    String afterDate,
  });

  Future<Either<Failure, ComparePhotoDataModel>> getComparePhotoData({int offSet});

  Future<Either<Failure, WeightModel>> getWeight({double weight, int pic});

  Future<Either<Failure, ImageModel>> getPhoto({File image, int pic});

  Future<Either<Failure, DateModel>> getDate({DateTime dateTime, int pic});
}
