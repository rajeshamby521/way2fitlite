import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:way2fitlife/features/login/presentation/pages/login_screen.dart';
import 'package:way2fitlife/features/logout/logout_model.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference.dart';

logOut(context) async {
  Dio _dio = Dio(options);
  LogOutModel logOutModel;

  Map<String, dynamic> map = Map();
  map[user_id] = AppPreference.getString(user_id);
  map[access_token] = AppPreference.getString(access_token);
  map[device_token] = AppPreference.getString(device_token);
  map[lang] = "0";

  var response = await _dio.post(LogoutURL, data: FormData.fromMap(map));
  logOutModel = LogOutModel.fromMap(response.data);

  if (logOutModel.flag == 1) AppPreference.clear();
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => LogInScreen()),
    (Route<dynamic> route) => false,
  );
}
