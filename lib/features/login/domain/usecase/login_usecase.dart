import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/login/domain/repository/login_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';

class LogInButtonStatusUseCase extends UseCase<ErrorStatusModel, LogInButtonStatusParams> {
  LogInRepository logInRepository;

  LogInButtonStatusUseCase({this.logInRepository});

  @override
  Future<Either<Failure, ErrorStatusModel>> call(LogInButtonStatusParams params) async {
    return await logInRepository.getLogInButtonStatusData(
      emailValid: params.emailValid,
      passwordValid: params.passwordValid,
      emailMsg: params.emailMsg,
      passMsg: params.passMsg,
    );
  }
}

class LogInButtonStatusParams extends Equatable {
  final bool emailValid;
  final bool passwordValid;
  final String emailMsg;
  final String passMsg;

  LogInButtonStatusParams({this.emailValid, this.passwordValid, this.emailMsg, this.passMsg});

  @override
  List<Object> get props => [emailValid, passwordValid, emailMsg, passMsg];
}

class LogInUseCase extends UseCase<LogInModel, LogInParams> {
  LogInRepository logInRepository;

  LogInUseCase({this.logInRepository});

  @override
  Future<Either<Failure, LogInModel>> call(LogInParams params) async {
    return await logInRepository.getLogInData(
      email: params.email,
      password: params.password,
    );
  }
}

class LogInParams extends Equatable {
  final String email;
  final String password;

  LogInParams({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
