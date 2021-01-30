import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/register_page/data/datamodel/register_data_model.dart';
import 'package:way2fitlife/features/update_user_data/data/datamodel/change_password_data_model.dart';
import 'package:way2fitlife/features/update_user_data/data/dataresourse/update_user_data_resourse.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference_util.dart';class UpdateUserDataResourseIml extends UpdateUserDataResourse {
  LogInModel updatedDataModel;
  ChangePasswordDataModel changePasswordDataModel;
  Dio dio = Dio(options);

  @override
  Future<LogInModel> updateUserData(
      {RegisterDataModel registerDataModel}) async {
    String activityTYpe = "1";
    switch (registerDataModel.activityBuilder) {
      case "Normal":
        activityTYpe = "1";
        break;
      case "Light":
        activityTYpe = "2";
        break;
      case "Medium":
        activityTYpe = "3";
        break;
      case "Active":
        activityTYpe = "4";
        break;
    }
    Map<String, dynamic> map = Map();
    map[username] = registerDataModel.uname ?? " ";
    map[gender] = (registerDataModel.gender.compareTo("Gender.male")) == 0
        ? "Male"
        : "Female" ?? "";
    map[param_height] = registerDataModel.height ?? "";
    map[param_weight] = registerDataModel.weight ?? " ";
    map[birthdate] = registerDataModel.birthdate;
    map[mobile] = registerDataModel.mobile ?? "";
    map[activity_type] = activityTYpe;

    if (registerDataModel.image != null) {
      String filename = registerDataModel.image.path.split('/').last;
      map[profile_image] = await MultipartFile.fromFile(
          registerDataModel.image.path,
          filename: filename);
    }
    map[lang] = "0";
    map[emailID] = registerDataModel.email ?? "";
    map[user_id] = AppPreferenceUtil().readString(user_id).toString();
    map[access_token] = AppPreferenceUtil().readString(access_token).toString();

    print("mapppp====>${map}");
    Response response =
        await dio.post(UpdateUserURL, data: FormData.fromMap(map));
    print('response model---> ${response.data}');
    updatedDataModel = logInModelFromJson(response.data);
    if (updatedDataModel.flag == 1) {
      AppPreferenceUtil().writeString(userData, jsonEncode(response.data['data']));
      AppPreferenceUtil().writeString(user_id, updatedDataModel.data.userId.toString());
      AppPreferenceUtil().writeString(
          access_token, updatedDataModel.data.accessToken.toString());
    }
    return updatedDataModel;
  }

  @override
  Future<ChangePasswordDataModel> changePassword(
      {String c_pass, String n_pass}) async {
    Map<String, dynamic> map = Map();
    map[current_password] = c_pass ?? "";
    map[new_password] = n_pass ?? "";
    map[lang] = "0";
    map[user_id] = AppPreferenceUtil().readString(user_id).toString();
    map[access_token] = AppPreferenceUtil().readString(access_token).toString();
    print('map-->$map');
    Response response =
        await dio.post(ChangePasswordURL, data: FormData.fromMap(map));
    print('changepasswordmodel-->${response.data}');
    changePasswordDataModel = changePasswordDataModelFromJson(response.data);
    return changePasswordDataModel;
  }
}
