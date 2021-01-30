import 'package:dio/dio.dart';
import 'package:way2fitlife/features/weight_sheet/data/datamodel/set_weight_data_model.dart';
import 'package:way2fitlife/features/weight_sheet/data/datamodel/weight_sheet_model.dart';
import 'package:way2fitlife/features/weight_sheet/data/datasource/weight_sheet_datasource.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference_util.dart';import 'package:intl/intl.dart';

class WeightSheetDataSourceImpl extends WeightSheetDataSource {
  Dio _dio = Dio(options);
  WeightSheetModel data;
  SetWeightDataModel setData;

  @override
  Future<double> getWeight({double weight}) async => weight;

  @override
  Future<DateTime> getDate({DateTime dateTime}) async => dateTime;

  @override
  Future<WeightSheetModel> getWeightSheetData({int offSet}) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreferenceUtil().readString(user_id);
    map[access_token] = AppPreferenceUtil().readString(access_token);
    map[lang] = "0";
    map[offset] = offSet.toString();

    var response = await _dio.post(getWeightSheetListURL, data: FormData.fromMap(map));
    data = WeightSheetModel.fromMap(response.data);

    // weightList.add({
    //   "weight": weight.toString(),
    //   "dateTime": dateTime.toString(),
    // });
    // data = WeightSheetModel.fromMap(_weightSheetList);

    return data;
  }

  @override
  Future<SetWeightDataModel> setWeightSheetData({String date, String weight}) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreferenceUtil().readString(user_id);
    map[access_token] = AppPreferenceUtil().readString(access_token);
    map[lang] = "0";
    map[param_date] = date;
    map[param_weight] = weight;

    var response = await _dio.post(setWeightSheetDataURL, data: FormData.fromMap(map));
    setData = SetWeightDataModel.fromMap(response.data);
    return setData;
  }
}

// final _weightSheetList = {"status": 200, "weight list": weightList};
//
// dynamic weightList = [
//   {"weight": "40", "dateTime": "2020-10-01 10:06:40.285"},
//   {"weight": "50", "dateTime": "2020-10-01 10:06:40.285"},
// ];
