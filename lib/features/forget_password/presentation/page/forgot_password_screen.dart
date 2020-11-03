import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/general/buttons.dart';
import 'package:way2fitlife/common/general/field_and_label.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/feedback/presentation/widget/feedback_widget.dart';
import 'package:way2fitlife/features/forget_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:way2fitlife/features/forget_password/presentation/bloc/forgot_password_event.dart';
import 'package:way2fitlife/features/forget_password/presentation/bloc/forgot_password_state.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  Bloc bloc = getIt<ForgotPasswordBloc>();
  bool buttonStatus = false;
  String emailMsg = '';
  String email = '';
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc.add(ForgotPasswordBtnEvent(email: email));
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          forgotPasswordTxt,
        ),
        backgroundColor: headerColor,
      ),
      body: SafeArea(
        child: BlocListener(
          cubit: bloc,
          listener: (context, state) {
            if (state is ForgotPasswordErrorState) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.msg),
              ));
            }
            if (state is ForgotPasswordBtnStatuState) {
              buttonStatus = state.status;
              emailMsg = state.email;
            } else if (state is ForgotPasswordCompleteState) {
              if (state.model.flag == 1) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.model.msg),
                ));
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.model.msg),
                ));
              }
            } else {
              buttonStatus = false;
            }
          },
          child: BlocBuilder(
            cubit: bloc,
            builder: (BuildContext context, state) {
              return Center(
                child: Stack(
                  children: [
                    bgImg,
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Card(
                        elevation: 10,
                        color: Colors.white70,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FieldAndLabel(
                                fieldType: FieldType.TextField,
                                enabled: true,
                                hint: enter_email,
                                controller: emailController,
                                inputType: TextInputType.text,
                                validationMessage: emailMsg,
                                inputAction: TextInputAction.done,
                                onChanged: (value) {
                                  email = value;
                                  bloc.add(
                                      ForgotPasswordBtnEvent(email: email));
                                },
                              ),
                              verticalSpace(10),
                              submitButton(
                                  text: submit,
                                  textColor: white,
                                  disable: !buttonStatus,
                                  onPressed: () {
                                    bloc.add(ForgotPasswordCompleteEvent(
                                        email: emailController.text));
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
