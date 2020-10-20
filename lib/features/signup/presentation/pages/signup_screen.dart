import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/home/presentation/widget/home_widget.dart';
import 'package:way2fitlife/features/signup/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/signup/presentation/widget/signup_widget.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  Bloc bloc = getIt<SignUpBloc>();

  SignUpScreen({this.bloc});

  String emailValidationMsg = "";
  String passwordValidationMsg = "";
  bool buttonStatus = false;
  bool gender = false;

  @override
  Widget build(BuildContext context) {
    Scr.setScreenSize(context);
    return SafeArea(
      child: Scaffold(
        body: BlocListener(
          cubit: bloc,
          listener: (BuildContext context, state) {
            if (state is GetSignUpEmailState) emailValidationMsg = state.msg;
            if (state is GetSignUpPasswordState) passwordValidationMsg = state.msg;
            if (state is GetSignUpButtonStatusState) buttonStatus = state.status;
            if (state is GetSignUpGenderState) gender = state.gender;
          },
          child: BlocBuilder(
            cubit: bloc,
            builder: (context, state) => Container(
              height: height,
              decoration: boxDecoration(
                image: bg_home_screen2,
                // colorFilter: ColorFilter.mode(black.withOpacity(0.8), BlendMode.dstATop),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imageAsset(img: appLogo, height: height * 0.2),
                    SignUpCard(
                      gender: gender,
                      bloc: bloc,
                      emailMsg: emailValidationMsg,
                      passMsg: passwordValidationMsg,
                      buttonStatus: buttonStatus,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
