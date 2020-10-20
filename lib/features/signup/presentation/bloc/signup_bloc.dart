import 'package:way2fitlife/features/signup/domain/usecase/signup_usecase.dart';
import 'package:way2fitlife/features/signup/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpUseCase signUpUseCase;
  SignUpEmailUseCase signUpEmailUseCase;
  SignUpPasswordUseCase signUpPasswordUseCase;
  SignUpButtonStatusUseCase signUpButtonStatusUseCase;
  SignUpGenderUseCase signUpGenderUseCase;

  SignUpBloc({
    this.signUpEmailUseCase,
    this.signUpButtonStatusUseCase,
    this.signUpPasswordUseCase,
    this.signUpUseCase,
  }) : super(InitialSignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is GetSignUpEvent) {
      final result = signUpUseCase.call();
      yield GetSignUpState(msg: result);
    }
    if (event is GetSignUpEmailEvent) {
      final result = signUpEmailUseCase.call();
      yield GetSignUpEmailState(msg: result);
    }
    if (event is GetSignUpPasswordEvent) {
      final result = signUpPasswordUseCase.call();
      yield GetSignUpPasswordState(msg: result);
    }
    if (event is GetSignUpButtonStatusEvent) {
      final result = signUpButtonStatusUseCase.call();
      yield GetSignUpButtonStatusState(status: result);
    }
    if (event is GetSignUpGenderEvent) {
      final result = signUpGenderUseCase.call();
      yield GetSignUpGenderState(gender: result);
    }
  }
}
