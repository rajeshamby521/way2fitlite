import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:way2fitlife/features/login/presentation/pages/login_screen.dart';
import 'package:way2fitlife/features/logout/logout_model.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference_util.dart';

logOut(context) async {
  Dio _dio = Dio(options);
  LogOutModel logOutModel;

  Map<String, dynamic> map = Map();
  map[user_id] = AppPreferenceUtil().readString(user_id);
  map[access_token] = AppPreferenceUtil().readString(access_token);
  map[device_token] = AppPreferenceUtil().readString(device_token);
  map[lang] = "0";

  // AppPreference.clear();

  var response = await _dio.post(LogoutURL, data: FormData.fromMap(map));
  logOutModel = LogOutModel.fromMap(response.data);

  if (logOutModel.flag == 1)
    SharedPreferences.getInstance().then((value) {
      value.clear();
    });
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => LogInScreen()),
        (Route<dynamic> route) => false,
  );
}
