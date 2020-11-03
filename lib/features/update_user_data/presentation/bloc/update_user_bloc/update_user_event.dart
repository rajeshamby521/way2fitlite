import 'dart:io';

import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';

abstract class UpdateUserEvent {}

class UpdateUserInitialEvent extends UpdateUserEvent {
  final String uname;
  final String gender;
  final String height;
  final String weight;
  final String birthdate;
  final String email;
  final String mobile;
  final String activityBuilder;

  UpdateUserInitialEvent(
      {this.uname,
      this.gender,
      this.height,
      this.weight,
      this.birthdate,
      this.email,
      this.mobile,
      this.activityBuilder});
}

class UpdateUserDataEvent extends UpdateUserEvent {
  final String uname;
  final String gender;
  final String height;
  final String weight;
  final String birthdate;
  final String email;
  final String mobile;
  final String activityBuilder;
  File image;
  UserData data;

  UpdateUserDataEvent(
      {this.uname,
      this.gender,
      this.height,
      this.weight,
      this.birthdate,
      this.email,
      this.mobile,
      this.activityBuilder,
      this.image,
      this.data});
}
