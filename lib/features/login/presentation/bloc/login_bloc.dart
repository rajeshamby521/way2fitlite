import 'package:way2fitlife/common/validation.dart';
import 'package:way2fitlife/features/login/domain/usecase/login_usecase.dart';
import 'package:way2fitlife/features/login/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInButtonStatusUseCase logInButtonStatusUseCase;
  LogInUseCase logInUseCase;

  LogInBloc({this.logInButtonStatusUseCase, this.logInUseCase}) : super(InitialLogInState());

  @override
  Stream<LogInState> mapEventToState(LogInEvent event) async* {
    if (event is GetLogInButtonStatusEvent) {
      yield LoadingBeginHomeState();

      String emailMsg = emailValidationMsg(email: event.email);
      String passMsg = passwordValidationMsg(password: event.password);

      bool emailValid = isEmailValid(email: emailMsg);
      bool passwordValid = isPasswordValid(password: passMsg);

      final result = await logInButtonStatusUseCase(LogInButtonStatusParams(
        emailValid: emailValid,
        passwordValid: passwordValid,
        emailMsg: emailMsg,
        passMsg: passMsg,
      ));
      yield LoadingEndHomeState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetLogInButtonStatusState(errorStatusModel: success),
      );
    }
    if (event is GetLogInEvent) {
      yield LoadingBeginHomeState();
      final result = await logInUseCase(LogInParams(
        email: event.email,
        password: event.password,
      ));
      yield LoadingEndHomeState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetLogInState(logInModel: success),
      );
    }
  }
}
