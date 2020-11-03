import 'package:way2fitlife/ui_helper/strings.dart';

String emailValidationMsg({String email}) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (email.isEmpty) {
    return requiredField;
  } else if (regex.hasMatch(email)) {
    return valid;
  } else
    return '$invalid Email';
}

String passwordValidationMsg({String password}) {
  if (password.isEmpty)
    return requiredField;
  else if (password.length < 6)
    return passwordLength6;
  else if (password.length >= 6)
    return valid;
  else
    return passwordLength6;
}

//new
String activityValidationMsg({String activity}) {
  if (activity.compareTo("Activity Level") == 0)
    return requiredField;
  else if (activity.isEmpty)
    return requiredField;
  else
    return valid;
}

String feedbackValidationMsg({String value}) {
  if (value.isEmpty)
    return requiredField;
  else
    return valid;
}

String emptyValidationMsg({String emptyField}) {
  if (emptyField.isEmpty)
    return requiredField;
  else
    return valid;
}

//for change passowrd's new password
String passwordMatch({String c_password, String n_password}) {
  if (n_password.isEmpty)
    return requiredField;
  else if (n_password.length < 6)
    return passlenthMsg;
  else if (c_password == n_password)
    return passwordAreSame;
  else
    return valid;
}

//for change passowrd's confirm password
String passwordNotMatchMsg({String pass, String cpass}) {
  if (cpass.isEmpty) return requiredField;
  if (pass != cpass)
    return passwordAreNotSame;
  else
    return valid;
}

String cpasswordValidationMsg({String password, String cpassword}) {
  if (cpassword.isEmpty)
    return requiredField;
  else if (cpassword != password)
    return cpasswordPasswordNotMatch;
  else if (cpassword == password)
    return valid;
  else
    return cpasswordPasswordNotMatch;
}

String mobileValidationMsg({String mobile}) {
  if (mobile.isEmpty)
    return requiredField;
  else if (mobile.length == 10)
    return valid;
  else
    return '$invalid Mobile number';
}

bool isMobileValid({String mobile}) => mobile == valid ? true : false;

bool isEmptyValid({String emptyField}) => emptyField == valid ? true : false;

bool isCpasswordValid({String value}) => value == valid ? true : false;

bool isPasswordSameValid({String value}) => value == valid ? true : false;

bool isEmailValid({String email}) => email == valid ? true : false;

bool isPasswordValid({String password}) => password == valid ? true : false;

bool isFeedbackValid({String value}) => value == valid ? true : false;

bool isActivityValid({String value}) => value == valid ? true : false;
