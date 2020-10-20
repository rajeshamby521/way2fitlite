import 'dart:io';

import 'package:way2fitlife/features/compare/data/dataModel/compare_model.dart';
import 'package:way2fitlife/features/compare/data/dataModel/set_compare_data_model.dart';

abstract class CompareDataSource {
  Future<SetComparePhotoDataModel> setComparePhotoData({
    File beforePhoto,
    File afterPhoto,
    String beforeWeight,
    String afterWeight,
    String beforeDate,
    String afterDate,
  });

  Future<ComparePhotoDataModel> getComparePhotoData({int offSet});

  Future<ImageModel> getPhoto({File image, int pic});

  Future<WeightModel> getWeight({double weight, int pic});

  Future<DateModel> getDate({DateTime dateTime, int pic});
}
