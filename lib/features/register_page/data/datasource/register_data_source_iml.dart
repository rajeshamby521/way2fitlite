import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/register_page/data/datamodel/register_data_model.dart';
import 'package:way2fitlife/features/register_page/data/datasource/register_data_source.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference.dart';

class RegisterDataSourceiml extends RegisterDataSource {
  RegisterDataModel dataModel;
  LogInModel responseDataModel;
  Dio dio = Dio(options);

  @override
  Future<RegisterDataModel> getRegisterData() async {
    return dataModel;
  }

  @override
  Future<LogInModel> sendRegisterData({RegisterDataModel registermodel}) async {
    String activityType = "1";
    switch (registermodel.activityBuilder) {
      case "Normal":
        activityType = "1";
        break;
      case "Light":
        activityType = "2";
        break;
      case "Medium":
        activityType = "3";
        break;
      case "Active":
        activityType = "4";
        break;
    }
    String fileName = registermodel.image.path.split('/').last;
    Map<String, dynamic> map = Map();
    map[birthdate] = registermodel.birthdate;
    map[mobile] = registermodel.mobile ?? "";
    map[gender] = (registermodel.gender.compareTo("Gender.male")) == 0
        ? "Male"
        : "Female" ?? "";

    map[param_weight] = registermodel.weight ?? "";
    map[device_type] = "1";
    map[userPassword] = registermodel.pass ?? "";
    map[activity_type] = activityType;
    map[device_token] = "1";
    map[lang] = "0";
    map[emailID] = registermodel.email ?? "";
    map[username] = registermodel.uname ?? "";
    map["height"] = registermodel.height ?? "";
    map[profile_image] = await MultipartFile.fromFile(registermodel.image.path,
        filename: fileName);

    print(map);

    Response response =
        await dio.post(RegisterURL, data: FormData.fromMap(map));
    print('response model');
    print(response.data);

    responseDataModel = logInModelFromJson((response.data));

    if (responseDataModel.flag == 1) {
      AppPreference.set(userData, jsonEncode(response.data['data']));
      AppPreference.set(user_id, responseDataModel.data.userId);
      AppPreference.set(access_token, responseDataModel.data.accessToken);
    }

    return responseDataModel;
  }
}
