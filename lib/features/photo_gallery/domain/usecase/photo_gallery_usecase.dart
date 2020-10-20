import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/photo_gallery/data/dataModel/photo_gallery_model.dart';
import 'package:way2fitlife/features/photo_gallery/data/dataModel/set_photo_gallery_data_model.dart';
import 'package:way2fitlife/features/photo_gallery/domain/repository/photo_gallery_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';

class PhotoGalleryDataUseCase extends UseCase<PhotoGalleryModel, PhotoGalleryDataParams> {
  PhotoGalleryRepository photoGalleryRepository;

  PhotoGalleryDataUseCase({this.photoGalleryRepository});

  @override
  Future<Either<Failure, PhotoGalleryModel>> call(PhotoGalleryDataParams params) async =>
      photoGalleryRepository.getPhotoGalleryDate(offSet: params.offSet);
}

class PhotoGalleryDataParams extends Equatable {
  final int offSet;

  PhotoGalleryDataParams({this.offSet});

  @override
  List<Object> get props => [offSet];
}

class SetPhotoGalleryDataUseCase
    extends UseCase<SetPhotoGalleryDataModel, SetPhotoGalleryDataParams> {
  PhotoGalleryRepository photoGalleryRepository;

  SetPhotoGalleryDataUseCase({this.photoGalleryRepository});

  @override
  Future<Either<Failure, SetPhotoGalleryDataModel>> call(SetPhotoGalleryDataParams params) async =>
      photoGalleryRepository.setPhotoGalleryDate(
        image: params.image,
        weight: params.weight,
        date: params.date,
      );
}

class SetPhotoGalleryDataParams extends Equatable {
  final File image;
  final String date;
  final String weight;

  SetPhotoGalleryDataParams({this.image, this.date, this.weight});

  @override
  List<Object> get props => [image, date, weight];
}

class PhotoGalleryPhotoUseCase extends UseCase<File, PhotoGalleryPhotoParams> {
  PhotoGalleryRepository photoGalleryRepository;

  PhotoGalleryPhotoUseCase({this.photoGalleryRepository});

  @override
  Future<Either<Failure, File>> call(PhotoGalleryPhotoParams params) async =>
      photoGalleryRepository.getPhoto(image: params.image);
}

class PhotoGalleryPhotoParams extends Equatable {
  final File image;

  PhotoGalleryPhotoParams({this.image});

  @override
  List<Object> get props => [image];
}

class PhotoGalleryWeightUseCase extends UseCase<double, PhotoGalleryWeightParams> {
  PhotoGalleryRepository photoGalleryRepository;

  PhotoGalleryWeightUseCase({this.photoGalleryRepository});

  @override
  Future<Either<Failure, double>> call(PhotoGalleryWeightParams params) async =>
      photoGalleryRepository.getWeight(weight: params.weight);
}

class PhotoGalleryWeightParams extends Equatable {
  final double weight;

  PhotoGalleryWeightParams({this.weight});

  @override
  List<Object> get props => [weight];
}

class PhotoGalleryDateUseCase extends UseCase<DateTime, PhotoGalleryDateParams> {
  PhotoGalleryRepository photoGalleryRepository;

  PhotoGalleryDateUseCase({this.photoGalleryRepository});

  @override
  Future<Either<Failure, DateTime>> call(PhotoGalleryDateParams params) async =>
      photoGalleryRepository.getDate(dateTime: params.dateTime);
}

class PhotoGalleryDateParams extends Equatable {
  final DateTime dateTime;

  PhotoGalleryDateParams({this.dateTime});

  @override
  List<Object> get props => [dateTime];
}
