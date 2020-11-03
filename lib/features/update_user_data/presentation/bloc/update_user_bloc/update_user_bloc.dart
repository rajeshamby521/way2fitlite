import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/validation.dart';
import 'package:way2fitlife/features/register_page/data/datamodel/register_data_model.dart';
import 'package:way2fitlife/features/update_user_data/domain/usecase/update_user_use_case.dart';
import 'package:way2fitlife/features/update_user_data/presentation/bloc/update_user_bloc/update_user_event.dart';
import 'package:way2fitlife/features/update_user_data/presentation/bloc/update_user_bloc/update_user_state.dart';

bool valid = false;

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  UpdateUserUseCase updateUserUseCase;

  UpdateUserBloc({this.updateUserUseCase}) : super(null);

  @override
  Stream<UpdateUserState> mapEventToState(UpdateUserEvent event) async* {
    if (event is UpdateUserInitialEvent) {
      String unmaeMsg = emptyValidationMsg(emptyField: event.uname);
      String heightMsg = emptyValidationMsg(emptyField: event.height);
      String weightMsg = emptyValidationMsg(emptyField: event.weight);
      String emailMsg = emailValidationMsg(email: event.email);
      String mobileMsg = mobileValidationMsg(mobile: event.mobile);
      String activityMsg =
          activityValidationMsg(activity: event.activityBuilder);

      valid = (isEmptyValid(emptyField: unmaeMsg) &&
          isEmptyValid(emptyField: heightMsg) &&
          isEmptyValid(emptyField: weightMsg) &&
          isEmailValid(email: emailMsg) &&
          isMobileValid(mobile: mobileMsg) &&
          isActivityValid(value: activityMsg));

      yield UpdateUserIntialState(
        status: valid,
        unameMsg: unmaeMsg,
        heightMsg: heightMsg,
        weightMsg: weightMsg,
        emailMsg: emailMsg,
        mobileMsg: mobileMsg,
        activityMsg: activityMsg,
      );
    }
    if (event is UpdateUserDataEvent) {
      RegisterDataModel model = RegisterDataModel(
        uname: event.uname,
        gender: event.gender,
        height: event.height,
        weight: event.weight,
        birthdate: event.birthdate,
        email: event.email,
        mobile: event.mobile,
        activityBuilder: event.activityBuilder,
        image: event.image,
      );
      print(model);
      yield UpdateUserLodingBeginState();
      final result =
          await updateUserUseCase(UpdateUserUseCaseParams(model: model));

      yield UpdateUserLodingEndState();

      yield result.fold(
          (error) => UpdateUserErrorState(msg: error.runtimeType.toString()),
          (result) => UpdateUserComplteState(model: result));
    }
  }
}
