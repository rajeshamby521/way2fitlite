import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:way2fitlife/common/general/buttons.dart';
import 'package:way2fitlife/common/general/field_and_label.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/logout/logout_api_alert.dart';
import 'package:way2fitlife/features/update_user_data/presentation/bloc/change_passowrd_bloc/bloc.dart';
import 'package:way2fitlife/features/update_user_data/presentation/bloc/change_passowrd_bloc/change_password_event.dart';
import 'package:way2fitlife/features/update_user_data/presentation/bloc/change_passowrd_bloc/change_password_state.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/icons.dart';
import 'package:way2fitlife/utils/app_preference.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool btnStatus = false;
  String c_passMsg = '';
  String n_passMsg = '';
  String conf_passMsg = '';
  Bloc bloc = getIt<ChangePasswordBloc>();

  TextEditingController cpassController = TextEditingController();
  TextEditingController npassController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();
  FocusNode cpassFocusNode = FocusNode();
  FocusNode npassFocusNode = FocusNode();
  FocusNode confirmpassFocusNode = FocusNode();

  String cPass = '';
  String nPass = '';
  String confirmPass = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    cpassController.dispose();
    npassController.dispose();
    confirmpassController.dispose();
    cpassFocusNode.dispose();
    npassFocusNode.dispose();
    confirmpassFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        //height: Scr.screenHeight * 0.4,
        width: Scr.screenWidth * 0.9,
        child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
          cubit: bloc,
          listener: (context, state) {
            if (state is ChangePasswordErrorState) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.msg)));
            } else if (state is ChangePasswordBtnState) {
              btnStatus = state.status;
              c_passMsg = state.c_passMsg;
              n_passMsg = state.n_passMsg;
              conf_passMsg = state.conf_pass;
            } else if (state is ChangePasswordCompleteState) {
              if (state.model.flag == 1) {
                AppPreference.prefs
                    .setString(access_token, state.model.accessToken);
                Fluttertoast.showToast(msg: state.model.msg);
                //AppPreference.clear();
                logOut(context);
              } else {
                Fluttertoast.showToast(msg: state.model.msg);
              }
            } else
              btnStatus = false;
          },
          child: BlocBuilder(
            cubit: bloc,
            builder: (context, state) => changePassword(),
          ),
        ),
      ),
    );
  }

  Widget changePassword() {
    return Wrap(
      runSpacing: 10.0,
      children: [
        FieldAndLabel(
          hint: "old password",
          icon: Image.asset(
            ic_password,
            height: 25,
            width: 25,
          ),
          enabled: true,
          controller: cpassController,
          focusNode: cpassFocusNode,
          nextFocusNode: npassFocusNode,
          inputAction: TextInputAction.next,
          validationMessage: c_passMsg,
          isPassword: true,
          onChanged: (val) {
            cPass = val;
            bloc.add(ChangePasswordBtnStatus(
              current_password: cPass,
              new_password: nPass,
              confirm_password: confirmPass,
            ));
          },
        ),
        FieldAndLabel(
          hint: "New passowrd",
          enabled: true,
          icon: Image.asset(
            ic_password,
            height: 25,
            width: 25,
          ),
          controller: npassController,
          isPassword: true,
          focusNode: npassFocusNode,
          nextFocusNode: confirmpassFocusNode,
          inputAction: TextInputAction.next,
          validationMessage: n_passMsg,
          onChanged: (val) {
            nPass = val;
            bloc.add(ChangePasswordBtnStatus(
              current_password: cPass,
              new_password: nPass,
              confirm_password: confirmPass,
            ));
          },
        ),
        FieldAndLabel(
          hint: "Retype",
          controller: confirmpassController,
          validationMessage: conf_passMsg,
          focusNode: confirmpassFocusNode,
          inputAction: TextInputAction.done,
          nextFocusNode: null,
          isPassword: true,
          icon: Image.asset(
            ic_password,
            height: 25,
            width: 25,
          ),
          enabled: true,
          onChanged: (val) {
            confirmPass = val;
            bloc.add(ChangePasswordBtnStatus(
              current_password: cPass,
              new_password: nPass,
              confirm_password: confirmPass,
            ));
          },
        ),
        Center(
          child: submitButton(
              text: 'Change Password',
              textColor: white,
              disable: !btnStatus,
              onPressed: () {
                bloc.add(ChangePasswordCompleteEvent(
                  current_password: cpassController.text,
                  new_password: npassController.text,
                ));
              }),
        ),
      ],
    );
  }
}
