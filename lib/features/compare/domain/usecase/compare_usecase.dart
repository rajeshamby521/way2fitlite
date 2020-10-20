import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/compare/data/dataModel/compare_model.dart';
import 'package:way2fitlife/features/compare/data/dataModel/set_compare_data_model.dart';
import 'package:way2fitlife/features/compare/domain/repository/compare_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';

//Compare data UseCase
class GetCompareDataUseCase extends UseCase<ComparePhotoDataModel, GetCompareDataParmas> {
  CompareRepository compareRepository;

  GetCompareDataUseCase({this.compareRepository});

  @override
  Future<Either<Failure, ComparePhotoDataModel>> call(GetCompareDataParmas params) async =>
      compareRepository.getComparePhotoData(offSet: params.offSet);
}

class GetCompareDataParmas extends Equatable {
  int offSet;

  GetCompareDataParmas({this.offSet});

  @override
  List<Object> get props => [offSet];
}

//Photo UseCase
class ComparePhotoUseCase extends UseCase<ImageModel, CompareImageParams> {
  CompareRepository compareRepository;

  ComparePhotoUseCase({this.compareRepository});

  @override
  Future<Either<Failure, ImageModel>> call(CompareImageParams params) async =>
      compareRepository.getPhoto(image: params.image, pic: params.pic);
}

class CompareImageParams extends Equatable {
  File image;
  int pic;

  CompareImageParams({this.image, this.pic});

  @override
  List<Object> get props => [image, pic];
}

// Weight UseCase
class CompareWeightUseCase extends UseCase<WeightModel, CompareWeightParams> {
  CompareRepository compareRepository;

  CompareWeightUseCase({this.compareRepository});

  @override
  Future<Either<Failure, WeightModel>> call(CompareWeightParams params) async =>
      compareRepository.getWeight(weight: params.weight, pic: params.pic);
}

class CompareWeightParams extends Equatable {
  double weight;
  int pic;

  CompareWeightParams({this.weight, this.pic});

  @override
  List<Object> get props => [weight, pic];
}

// Date UseCase
class CompareDateUseCase extends UseCase<DateModel, CompareDateParams> {
  CompareRepository compareRepository;

  CompareDateUseCase({this.compareRepository});

  @override
  Future<Either<Failure, DateModel>> call(CompareDateParams params) async =>
      compareRepository.getDate(dateTime: params.dateTime, pic: params.pic);
}

class CompareDateParams extends Equatable {
  DateTime dateTime;
  int pic;

  CompareDateParams({this.dateTime, this.pic});

  @override
  List<Object> get props => [dateTime, pic];
}

//Set Compare Data UseCase

class SetCompareDataUseCase extends UseCase<SetComparePhotoDataModel, SetCompareDataParams> {
  CompareRepository compareRepository;

  SetCompareDataUseCase({this.compareRepository});

  @override
  Future<Either<Failure, SetComparePhotoDataModel>> call(SetCompareDataParams params) async =>
      compareRepository.setCompareDate(
        beforePhoto: params.beforeImage,
        afterPhoto: params.afterImage,
        beforeWeight: params.beforeWeight,
        afterWeight: params.afterWeight,
        beforeDate: params.beforeDate,
        afterDate: params.afterDate,
      );
}

class SetCompareDataParams extends Equatable {
  File beforeImage;
  File afterImage;
  String beforeWeight;
  String afterWeight;
  String beforeDate;
  String afterDate;

  SetCompareDataParams({
    this.beforeImage,
    this.afterImage,
    this.beforeWeight,
    this.afterWeight,
    this.beforeDate,
    this.afterDate,
  });

  @override
  List<Object> get props => [
        beforeImage,
        afterImage,
        beforeWeight,
        afterWeight,
        beforeDate,
        afterDate,
      ];
}
