import 'package:dio/dio.dart';
import 'package:way2fitlife/features/feedback/data/dataModel/feedback_model.dart';
import 'package:way2fitlife/features/feedback/data/dataSource/feedback_datasource.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference.dart';

class FeedbackDataSourceImpl extends FeedbackDataSource {
  Dio _dio = Dio(options);
  FeedbackModel data;

  @override
  Future<FeedbackModel> giveFeedbackData({String subject, String msg}) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreference.getString(user_id);
    map[access_token] = AppPreference.getString(access_token);
    map[lang] = "0";
    map[name] = subject;
    map[message] = msg;
    var response = await _dio.post(GiveFeedBackURL, data: FormData.fromMap(map));
    data = FeedbackModel.fromMap(response.data);
    return data;
  }

  @override
  Future<ErrorStatusModel> getFeedbackButtonStatusData(
      {bool subjectValid, bool messageValid, String subMsg, String msgMsg}) async {
    return await ErrorStatusModel(
      subMsg: subMsg,
      msgMsg: msgMsg,
      buttonStatus: (subjectValid && messageValid) ? true : false,
    );
  }
}
