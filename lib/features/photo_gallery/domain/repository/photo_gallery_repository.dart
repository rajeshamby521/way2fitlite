import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/photo_gallery/data/dataModel/photo_gallery_model.dart';
import 'package:way2fitlife/features/photo_gallery/data/dataModel/set_photo_gallery_data_model.dart';

abstract class PhotoGalleryRepository {
  Future<Either<Failure, PhotoGalleryModel>> getPhotoGalleryDate({int offSet});

  Future<Either<Failure, SetPhotoGalleryDataModel>> setPhotoGalleryDate(
      {File image, String date, String weight});

  Future<Either<Failure, double>> getWeight({double weight});

  Future<Either<Failure, File>> getPhoto({File image});

  Future<Either<Failure, DateTime>> getDate({DateTime dateTime});
}
