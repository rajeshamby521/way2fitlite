import 'dart:io';

import 'package:dio/dio.dart';
import 'package:way2fitlife/features/compare/data/dataModel/compare_model.dart';
import 'package:way2fitlife/features/compare/data/dataModel/set_compare_data_model.dart';
import 'package:way2fitlife/features/compare/data/dataSource/compare_datasource.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference.dart';

class CompareDataSourceImpl extends CompareDataSource {
  ComparePhotoDataModel data;
  SetComparePhotoDataModel setData;
  Dio _dio = Dio(options);

  @override
  Future<ComparePhotoDataModel> getComparePhotoData({int offSet}) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreference.getString(user_id);
    map[access_token] = AppPreference.getString(access_token);
    map[lang] = "0";
    map[offset] = offSet.toString();

    var response =
        await _dio.post(getComparePhotoListURL, data: FormData.fromMap(map));
    print('getCAompare photo--->${response.data}');
    data = ComparePhotoDataModel.fromMap(response.data);
    return data;
  }

  @override
  Future<DateModel> getDate({DateTime dateTime, int pic}) async =>
      DateModel(dateTime: dateTime, pic: pic);

  @override
  Future<ImageModel> getPhoto({File image, int pic}) async =>
      ImageModel(image: image, pic: pic);

  @override
  Future<WeightModel> getWeight({double weight, int pic}) async =>
      WeightModel(weight: weight, pic: pic);

  @override
  Future<SetComparePhotoDataModel> setComparePhotoData({
    File beforePhoto,
    File afterPhoto,
    String beforeWeight,
    String afterWeight,
    String beforeDate,
    String afterDate,
  }) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreference.getString(user_id);
    map[access_token] = AppPreference.getString(access_token);
    map[lang] = "0";
    map[before_weight] = beforeWeight;
    map[after_weight] = afterWeight;
    map[before_date] = beforeDate;
    map[after_date] = afterDate;

    String fileName1 = beforePhoto.path.split('/').last;
    map[user_before_photo] =
        await MultipartFile.fromFile(beforePhoto.path, filename: fileName1);
    String fileName2 = afterPhoto.path.split('/').last;
    map[user_after_photo] =
        await MultipartFile.fromFile(beforePhoto.path, filename: fileName2);

    var response =
        await _dio.post(SetComparePhotoDataURL, data: FormData.fromMap(map));

    print('set userphoto->>${response.data}');
    setData = SetComparePhotoDataModel.fromMap(response.data);
    return setData;
  }
}
