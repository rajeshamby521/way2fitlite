import 'package:way2fitlife/features/forget_password/data/datamodel/forogt_password_data_model.dart';

abstract class ForgotPasswordState {}

class ForgotPasswordInitState extends ForgotPasswordState {}

class ForgotPasswordBtnStatuState extends ForgotPasswordState {
  String email;
  bool status;

  ForgotPasswordBtnStatuState({this.email, this.status});
}

class ForgotPasswordErrorState extends ForgotPasswordState {
  String msg;

  ForgotPasswordErrorState({this.msg});
}

class ForgotPasswordCompleteState extends ForgotPasswordState {
  ForgotPasswordDataModel model;

  ForgotPasswordCompleteState({this.model});
}
