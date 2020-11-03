import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';

abstract class RegisterState {}

class RegisterInitState extends RegisterState {
  bool status = false;
  String unameMsg;
  String heightMsg;
  String weightMsg;
  String emailMsg;
  String mobileMsg;
  String passwordMsg;
  String cpasswordMsg;
  String activityMsg;

  RegisterInitState(
      {this.status,
      this.unameMsg,
      this.heightMsg,
      this.weightMsg,
      this.emailMsg,
      this.mobileMsg,
      this.passwordMsg,
      this.cpasswordMsg,
      this.activityMsg});
}

class RegisterLodingBeginState extends RegisterState {}

class RegisterLodingEndState extends RegisterState {}

class RegisterSendDataState extends RegisterState {
  final LogInModel model;

  RegisterSendDataState({this.model});
}

class RegisterErrorState extends RegisterState {
  final String msg;

  RegisterErrorState({this.msg});
}
