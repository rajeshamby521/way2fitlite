import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';

abstract class UpdateUserState {}

class UpdateUserIntialState extends UpdateUserState {
  bool status = false;
  String unameMsg;
  String heightMsg;
  String weightMsg;
  String emailMsg;
  String mobileMsg;
  String activityMsg;

  UpdateUserIntialState(
      {this.status,
      this.unameMsg,
      this.heightMsg,
      this.weightMsg,
      this.emailMsg,
      this.mobileMsg,
      this.activityMsg});
}

class UpdateUserLodingBeginState extends UpdateUserState {}

class UpdateUserLodingEndState extends UpdateUserState {}

class UpdateUserComplteState extends UpdateUserState {
  final LogInModel model;

  UpdateUserComplteState({this.model});
}

class UpdateUserErrorState extends UpdateUserState {
  final String msg;

  UpdateUserErrorState({this.msg});
}
