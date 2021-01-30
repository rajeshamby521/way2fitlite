import 'package:dio/dio.dart';
import 'package:way2fitlife/features/chart/data/dataModel/chart_model.dart';
import 'package:way2fitlife/features/chart/data/dataSource/chart_datasource.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference_util.dart';class ChartDataSourceImpl extends ChartDataSource {
  Dio _dio = Dio(options);
  ChartModel data;

  @override
  Future<ChartModel> getChartData({String dateType, String month}) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreferenceUtil().readString(user_id);
    map[access_token] = AppPreferenceUtil().readString(access_token);
    map[lang] = "0";
    map[param_month] = month;
    map[date_type] = dateType;

    var response = await _dio.post(ChartDataURL, data: FormData.fromMap(map));
    data = ChartModel.fromMap(response.data);
    return data;
  }
}
