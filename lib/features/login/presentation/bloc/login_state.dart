import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LogInState {}

class InitialLogInState extends LogInState {}

class LoadingBeginHomeState extends LogInState {}

class LoadingEndHomeState extends LogInState {}

class ErrorState extends LogInState {
  final String message;

  ErrorState(this.message);
}

class GetLogInButtonStatusState extends LogInState {
  final ErrorStatusModel errorStatusModel;

  GetLogInButtonStatusState({this.errorStatusModel});
}

class GetLogInState extends LogInState {
  final LogInModel logInModel;

  GetLogInState({this.logInModel});
}
