import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/validation.dart';
import 'package:way2fitlife/features/forget_password/domain/usecase/forgot_password_use_case.dart';
import 'package:way2fitlife/features/forget_password/presentation/bloc/bloc.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordBloc({this.forgotPasswordUseCase})
      : super(ForgotPasswordInitState());

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is ForgotPasswordBtnEvent) {
      String emailMsg = emailValidationMsg(email: event.email);

      bool valid = isEmailValid(email: emailMsg);

      yield ForgotPasswordBtnStatuState(
        status: valid,
        email: emailMsg,
      );
    }
    if (event is ForgotPasswordCompleteEvent) {
      String email = event.email;

      final result = await forgotPasswordUseCase(
          ForgotPasswordUseCaseParams(email: email));

      yield result.fold(
          (error) =>
              ForgotPasswordErrorState(msg: error.runtimeType.toString()),
          (result) => ForgotPasswordCompleteState(model: result));
    }
  }
}
