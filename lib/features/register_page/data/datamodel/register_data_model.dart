import 'dart:io';

class RegisterDataModel {
  String uname;
  String gender;
  String height;
  String weight;
  String birthdate;
  String email;
  String mobile;
  String activityBuilder;
  String pass;
  String cpass;
  File image;
  bool status = true;

  RegisterDataModel({
    this.uname,
    this.gender,
    this.height,
    this.weight,
    this.birthdate,
    this.email,
    this.mobile,
    this.activityBuilder,
    this.pass,
    this.cpass,
    this.image,
    this.status,
  });
}
