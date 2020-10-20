import 'package:meta/meta.dart';

@immutable
abstract class SignUpState {}

class InitialSignUpState extends SignUpState {}
class LoadingBeginHomeState extends SignUpState {}

class LoadingEndHomeState extends SignUpState {}

class ErrorState extends SignUpState {
  final String message;

  ErrorState(this.message);
}
class GetSignUpState extends SignUpState {
  String msg;

  GetSignUpState({this.msg});
}

class GetSignUpEmailState extends SignUpState {
  String msg;

  GetSignUpEmailState({this.msg});
}

class GetSignUpPasswordState extends SignUpState {
  String msg;

  GetSignUpPasswordState({this.msg});
}
class GetSignUpGenderState extends SignUpState {
  bool gender;

  GetSignUpGenderState({this.gender});
}

class GetSignUpButtonStatusState extends SignUpState {
  bool status;

  GetSignUpButtonStatusState({this.status});
}
