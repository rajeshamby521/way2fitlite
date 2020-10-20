import 'package:way2fitlife/features/signup/data/datasource/signup_datasource.dart';
import 'package:way2fitlife/ui_helper/strings.dart';

class SignUpDataSourceImpl extends SignUpDataSource {
  static String _email;
  static String _password;
  static bool _userGender;
  static String _emailValidationMessage;
  static String _passwordValidationMessage;

  static setSignUpData({String email, String password}) {
    _email = email;
    _password = password;
  }

  static setSignUpEmailData({String email}) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (email.isEmpty) {
      _emailValidationMessage = requiredField;
    } else if (regex.hasMatch(email)) {
      _emailValidationMessage = valid;
    } else
      _emailValidationMessage = '$invalid Email';
  }

  static setSignUpPasswordData({String password}) {
    if (password.isEmpty)
      _passwordValidationMessage = requiredField;
    else if (password.length < 6)
      _passwordValidationMessage = passwordLength6;
    else if (password.length > 6)
      _passwordValidationMessage = valid;
    else
      _passwordValidationMessage = passwordLength6;
  }

  static setSignUpGenderData({bool gender = false}) {
    _userGender = gender;
  }

  @override
  String getSignUpData() => success;

  @override
  String getSignUpEmailData() => _emailValidationMessage;

  @override
  String getSignUpPasswordData() => _passwordValidationMessage;

  @override
  bool getSignUpButtonStatusData() =>
      (_emailValidationMessage == valid && _passwordValidationMessage == valid) ? true : false;

  @override
  bool getSignUpGenderData() => _userGender;
}
