import 'dart:io';

abstract class RegiasterEvent {}

class RegisterInitEvent extends RegiasterEvent {
  final String uname;
  final String gender;
  final String height;
  final String weight;
  final String birthdate;
  final String email;
  final String mobile;
  final String activityBuilder;
  final String pass;
  final String cpass;

  RegisterInitEvent(
      {this.uname,
      this.gender,
      this.height,
      this.birthdate,
      this.weight,
      this.email,
      this.mobile,
      this.activityBuilder,
      this.pass,
      this.cpass});
}

class RegisterSendDataEvent extends RegiasterEvent {
  final String uname;
  final String gender;
  final String height;
  final String weight;
  final String birthdate;
  final String email;
  final String mobile;
  final String activityBuilder;
  final String pass;
  final String cpass;
  File image;

  RegisterSendDataEvent(
      {this.uname,
      this.gender,
      this.height,
      this.weight,
      this.birthdate,
      this.email,
      this.mobile,
      this.activityBuilder,
      this.pass,
      this.cpass,
      this.image});
}
