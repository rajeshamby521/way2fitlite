import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/photo_gallery/data/dataModel/photo_gallery_model.dart';
import 'package:way2fitlife/features/photo_gallery/data/dataModel/set_photo_gallery_data_model.dart';
import 'package:way2fitlife/features/photo_gallery/data/dataSource/photo_gallery_datasource.dart';
import 'package:way2fitlife/features/photo_gallery/domain/repository/photo_gallery_repository.dart';

class PhotoGalleryRepositoryImpl extends PhotoGalleryRepository {
  PhotoGalleryDataSource photoGalleryDataSource;

  PhotoGalleryRepositoryImpl({this.photoGalleryDataSource});

  @override
  Future<Either<Failure, DateTime>> getDate({DateTime dateTime}) async {
    final result = await photoGalleryDataSource.getDate(dateTime: dateTime);
    return Right(result);
  }

  @override
  Future<Either<Failure, File>> getPhoto({File image}) async {
    final result = await photoGalleryDataSource.getPhoto(image: image);
    return Right(result);
  }

  @override
  Future<Either<Failure, double>> getWeight({double weight}) async {
    final result = await photoGalleryDataSource.getWeight(weight: weight);
    return Right(result);
  }

  @override
  Future<Either<Failure, PhotoGalleryModel>> getPhotoGalleryDate({int offSet}) async {
    final result = await photoGalleryDataSource.getPhotoGalleryData(offSet: offSet);
    return Right(result);
  }

  @override
  Future<Either<Failure, SetPhotoGalleryDataModel>> setPhotoGalleryDate(
      {File image, String date, String weight}) async {
    final result = await photoGalleryDataSource.setPhotoGalleryData(
      image: image,
      date: date,
      weight: weight,
    );
    return Right(result);
  }
}
