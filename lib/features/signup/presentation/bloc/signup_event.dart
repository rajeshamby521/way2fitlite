import 'package:way2fitlife/features/signup/data/datasource/signup_datasource_impl.dart';

abstract class SignUpEvent {}

class GetSignUpEvent extends SignUpEvent {
  String email;
  String password;

  GetSignUpEvent({this.email, this.password}) {
    SignUpDataSourceImpl.setSignUpData(email: email, password: password);
  }
}

class GetSignUpEmailEvent extends SignUpEvent {
  String email;

  GetSignUpEmailEvent({this.email}) {
    SignUpDataSourceImpl.setSignUpEmailData(email: email);
  }
}

class GetSignUpPasswordEvent extends SignUpEvent {
  String password;

  GetSignUpPasswordEvent({this.password}) {
    SignUpDataSourceImpl.setSignUpPasswordData(password: password);
  }
}

class GetSignUpGenderEvent extends SignUpEvent {
  bool gender;

  GetSignUpGenderEvent({this.gender}) {
    SignUpDataSourceImpl.setSignUpGenderData(gender: gender);
  }
}

class GetSignUpButtonStatusEvent extends SignUpEvent {
  GetSignUpButtonStatusEvent();
}
