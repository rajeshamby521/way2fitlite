import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/login/data/datasource/login_datasource.dart';
import 'package:way2fitlife/features/login/domain/repository/login_repository.dart';

class LogInRepositoryImpl extends LogInRepository {
  LogInDataSource logInDataSource;

  LogInRepositoryImpl({this.logInDataSource});

  @override
  Future<Either<Failure, ErrorStatusModel>> getLogInButtonStatusData(
      {bool emailValid, bool passwordValid, String emailMsg, String passMsg}) async {
    final result = await logInDataSource.getLogInButtonStatusData(
        emailValid: emailValid, passwordValid: passwordValid, emailMsg: emailMsg, passMsg: passMsg);
    return Right(result);
  }

  @override
  Future<Either<Failure, LogInModel>> getLogInData({String email, String password}) async {
    final result = await logInDataSource.getLogInData(email: email, password: password);
    return Right(result);
  }
}
