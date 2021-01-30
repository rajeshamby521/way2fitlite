import 'dart:io';

import 'package:dio/dio.dart';
import 'package:way2fitlife/features/photo_gallery/data/dataModel/photo_gallery_model.dart';
import 'package:way2fitlife/features/photo_gallery/data/dataModel/set_photo_gallery_data_model.dart';
import 'package:way2fitlife/features/photo_gallery/data/dataSource/photo_gallery_datasource.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference_util.dart';class PhotoGalleryDataSourceImpl extends PhotoGalleryDataSource {
  PhotoGalleryModel data;
  SetPhotoGalleryDataModel setData;
  Dio _dio = Dio(options);

  @override
  Future<DateTime> getDate({DateTime dateTime}) async => dateTime;

  @override
  Future<File> getPhoto({File image}) async => image;

  @override
  Future<double> getWeight({double weight}) async => weight;

  @override
  Future<PhotoGalleryModel> getPhotoGalleryData({int offSet}) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreferenceUtil().readString(user_id);
    map[access_token] = AppPreferenceUtil().readString(access_token);
    map[lang] = "0";
    map[offset] = offSet.toString();

    var response = await _dio.post(getPhotoGalleryListURL, data: FormData.fromMap(map));
    data = PhotoGalleryModel.fromMap(response.data);
    return data;
  }

  @override
  Future<SetPhotoGalleryDataModel> setPhotoGalleryData(
      {File image, String date, String weight}) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreferenceUtil().readString(user_id);
    map[access_token] = AppPreferenceUtil().readString(access_token);
    map[lang] = "0";
    map[param_date] = date;
    map[param_weight] = weight;
    String fileName = image.path.split('/').last;
    map[user_photo] = await MultipartFile.fromFile(image.path, filename: fileName);

    var response = await _dio.post(setPhotoGalleryDataURL, data: FormData.fromMap(map));
    setData = SetPhotoGalleryDataModel.fromMap(response.data);
    return setData;
  }
}
