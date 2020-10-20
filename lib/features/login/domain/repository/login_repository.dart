import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';

abstract class LogInRepository {
  Future<Either<Failure, ErrorStatusModel>> getLogInButtonStatusData(
      {bool emailValid, bool passwordValid, String emailMsg, String passMsg});

  Future<Either<Failure, LogInModel>> getLogInData({String email, String password});
}
