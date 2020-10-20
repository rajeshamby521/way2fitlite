import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/login/data/datasource/login_datasource.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference.dart';
import 'dart:io' show Platform;

class LogInDataSourceImpl extends LogInDataSource {
  Dio _dio = Dio(options);
  LogInModel data;

  @override
  Future<ErrorStatusModel> getLogInButtonStatusData(
      {bool emailValid, bool passwordValid, String emailMsg, String passMsg}) async {
    return await ErrorStatusModel(
      emailMsg: emailMsg,
      passMsg: passMsg,
      buttonStatus: (emailValid && passwordValid) ? true : false,
    );
  }

  @override
  Future<LogInModel> getLogInData({String email, String password}) async {
    Map<String, dynamic> map = Map();
    map[device_token] = AppPreference.getString(device_token).toString();
    map[device_type] = Platform.isAndroid ? "1" : 0;
    map[lang] = "0";
    map[register_id] = "";
    map[emailID] = email;
    map[userPassword] = password;

    var responce = await _dio.post(getJSONLoginURL, data: FormData.fromMap(map));
    print("DATA :---  ${responce.data}");
    data = LogInModel.fromJson(responce.data);

    if (data.flag == 1) {
      print(data.data.userId);
      AppPreference.set(userData, jsonEncode(responce.data['data']));
      AppPreference.set(user_id, data.data.userId.toString());
      AppPreference.set(access_token, data.data.accessToken.toString());
    }

    return data;
  }
}
