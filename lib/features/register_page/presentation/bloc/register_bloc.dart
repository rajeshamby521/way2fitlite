import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/validation.dart';
import 'package:way2fitlife/features/register_page/data/datamodel/register_data_model.dart';
import 'package:way2fitlife/features/register_page/domain/usecase/register_use_case.dart';
import 'package:way2fitlife/features/register_page/presentation/bloc/register_event.dart';
import 'package:way2fitlife/features/register_page/presentation/bloc/register_state.dart';

bool valid = false;

class RegisterBloc extends Bloc<RegiasterEvent, RegisterState> {
  RegisterSendDataUseCase registerSendDataUseCase;

  RegisterBloc({this.registerSendDataUseCase}) : super(null);

  @override
  Stream<RegisterState> mapEventToState(RegiasterEvent event) async* {
    if (event is RegisterInitEvent) {
      String unmaeMsg = emptyValidationMsg(emptyField: event.uname);
      String heightMsg = emptyValidationMsg(emptyField: event.height);
      String weightMsg = emptyValidationMsg(emptyField: event.weight);
      String emailMsg = emailValidationMsg(email: event.email);
      String mobileMsg = mobileValidationMsg(mobile: event.mobile);
      String passwordMsg = passwordValidationMsg(password: event.pass);
      String cpasswordMsg =
          cpasswordValidationMsg(password: event.pass, cpassword: event.cpass);

      String activityMsg =
          activityValidationMsg(activity: event.activityBuilder);

      valid = (isEmptyValid(emptyField: unmaeMsg) &&
          isEmptyValid(emptyField: heightMsg) &&
          isEmptyValid(emptyField: weightMsg) &&
          isEmailValid(email: emailMsg) &&
          isMobileValid(mobile: mobileMsg) &&
          isPasswordValid(password: passwordMsg) &&
          isCpasswordValid(value: cpasswordMsg) &&
          isActivityValid(value: activityMsg));

      yield RegisterInitState(
        status: valid,
        unameMsg: unmaeMsg,
        heightMsg: heightMsg,
        weightMsg: weightMsg,
        emailMsg: emailMsg,
        mobileMsg: mobileMsg,
        passwordMsg: passwordMsg,
        cpasswordMsg: cpasswordMsg,
        activityMsg: activityMsg,
      );
    }
    if (event is RegisterSendDataEvent) {
      RegisterDataModel model = RegisterDataModel(
          uname: event.uname,
          gender: event.gender,
          height: event.height,
          weight: event.weight,
          birthdate: event.birthdate,
          email: event.email,
          mobile: event.mobile,
          activityBuilder: event.activityBuilder,
          pass: event.pass,
          cpass: event.cpass,
          image: event.image);

      yield RegisterLodingBeginState();
      final result2 = await registerSendDataUseCase(RegisterUseCaseParams(
        model: model,
      ));
      yield RegisterLodingEndState();
      yield result2.fold(
          (error) => RegisterErrorState(msg: error.runtimeType.toString()),
          (result2) => RegisterSendDataState(model: result2));
    }
  }
}
