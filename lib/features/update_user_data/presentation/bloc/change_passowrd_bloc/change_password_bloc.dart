import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/validation.dart';
import 'package:way2fitlife/features/update_user_data/domain/usecase/update_user_use_case.dart';
import 'package:way2fitlife/features/update_user_data/presentation/bloc/change_passowrd_bloc/bloc.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordBloc({this.changePasswordUseCase}) : super(null);

  @override
  Stream<ChangePasswordState> mapEventToState(
      ChangePasswordEvent event) async* {
    if (event is ChangePasswordBtnStatus) {
      String currentPassMsg =
          emptyValidationMsg(emptyField: event.current_password);
      String newPassMsg = passwordMatch(
          c_password: event.current_password, n_password: event.new_password);
      String confirmPasMsg = passwordNotMatchMsg(
          pass: event.new_password, cpass: event.confirm_password);

      bool valid = (isEmptyValid(emptyField: currentPassMsg) &&
          isPasswordValid(password: newPassMsg) &&
          isCpasswordValid(value: confirmPasMsg));

      yield ChangePasswordBtnState(
        status: valid,
        c_passMsg: currentPassMsg,
        n_passMsg: newPassMsg,
        conf_pass: confirmPasMsg,
      );
    }
    if (event is ChangePasswordCompleteEvent) {
      String currentPasword = event.current_password;
      String newPassword = event.new_password;

      final result = await changePasswordUseCase(ChangePasswordUseCaseParams(
          c_pass: currentPasword, n_pass: newPassword));
      yield result.fold(
          (error) =>
              ChangePasswordErrorState(msg: error.runtimeType.toString()),
          (result) => ChangePasswordCompleteState(model: result));
    }
  }
}
