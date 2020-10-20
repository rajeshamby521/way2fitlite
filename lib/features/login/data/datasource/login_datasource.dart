import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';

abstract class LogInDataSource {
  Future<ErrorStatusModel> getLogInButtonStatusData({
    bool emailValid,
    bool passwordValid,
    String emailMsg,
    String passMsg,
  });

  Future<LogInModel> getLogInData({String email, String password});
}
