import 'package:way2fitlife/features/update_user_data/data/datamodel/change_password_data_model.dart';

abstract class ChangePasswordState {}

class ChangePasswordBtnState extends ChangePasswordState {
  bool status = false;
  String c_passMsg;
  String n_passMsg;
  String conf_pass;

  ChangePasswordBtnState(
      {this.status, this.c_passMsg, this.n_passMsg, this.conf_pass});
}

class ChangePasswordCompleteState extends ChangePasswordState {
  ChangePasswordDataModel model;

  ChangePasswordCompleteState({this.model});
}

class ChangePasswordErrorState extends ChangePasswordState {
  String msg;

  ChangePasswordErrorState({this.msg});
}
