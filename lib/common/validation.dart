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

String feedbackValidationMsg({String value}) {
  if (value.isEmpty)
    return requiredField;
  else
    return valid;
}

bool isEmailValid({String email}) => email == valid ? true : false;

bool isPasswordValid({String password}) => password == valid ? true : false;

bool isFeedbackValid({String value}) => value == valid ? true : false;
