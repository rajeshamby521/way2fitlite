import 'package:way2fitlife/common/general/buttons.dart';
import 'package:way2fitlife/common/general/field_and_label.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/login/presentation/bloc/bloc.dart';
import 'package:way2fitlife/main.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/ui_helper/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget skipButton(BuildContext context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Align(
          alignment: Alignment.topRight,
          child: labels(text: skip, size: 20, color: white),
        ),
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
      ),
    );
String email = "";
String password = "";

class LogInCard extends StatelessWidget {
  final String emailMsg;
  final String passMsg;

  final Bloc bloc;
  final bool buttonStatus;

  LogInCard(
    BuildContext context, {
    this.bloc,
    this.buttonStatus,
    this.emailMsg,
    this.passMsg,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              labels(text: login, color: theme, size: 22),
              FieldAndLabel(
                icon: icons(icon: Icons.email, color: theme, size: 22),
                labelBackgroundColor: white,
                inputType: TextInputType.emailAddress,
                validationMessage: emailMsg,
                labelTextStyle: defaultHomeTextStyle(color: black),
                labelValue: txt_email,
                hint: enterEmail,
                enabled: true,
                onChanged: (value) {
                  email = value;
                  bloc.add(GetLogInButtonStatusEvent(email: email, password: password));
                },
              ),
              verticalSpace(10),
              FieldAndLabel(
                icon: icons(icon: Icons.lock, color: theme, size: 22),
                labelBackgroundColor: white,
                validationMessage: passMsg,
                labelTextStyle: defaultHomeTextStyle(color: black),
                labelValue: txt_password,
                hint: enterPassword,
                isPassword: true,
                enabled: true,
                onChanged: (value) {
                  password = value;
                  bloc.add(GetLogInButtonStatusEvent(email: email, password: password));
                },
              ),
              verticalSpace(10),
              submitButton(
                text: login,
                textColor: white,
                disable: !buttonStatus,
                onPressed: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  bloc.add(GetLogInEvent(email: email, password: password));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
