import 'package:way2fitlife/common/general/buttons.dart';
import 'package:way2fitlife/common/general/field_and_label.dart';
import 'package:way2fitlife/common/general/gender_widget.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/signup/presentation/bloc/bloc.dart';
import 'package:way2fitlife/main.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/icons.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/ui_helper/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCard extends StatelessWidget {
  Bloc bloc;
  String emailMsg;
  String passMsg;
  bool buttonStatus;
  bool gender;

  SignUpCard({this.bloc, this.gender, this.buttonStatus, this.passMsg, this.emailMsg});

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
              labels(text: signUp, color: theme, size: 22),
              FieldAndLabel(
                icon: icons(icon: Icons.email, color: theme, size: 22),
                labelBackgroundColor: white,
                inputType: TextInputType.emailAddress,
                validationMessage: emailMsg,
                labelTextStyle: defaultHomeTextStyle(color: Colors.black),
                labelValue: txt_email,
                hint: enterEmail,
                enabled: true,
                onChanged: (value) {
                  bloc.add(GetSignUpEmailEvent(email: value));
                  bloc.add(GetSignUpButtonStatusEvent());
                },
              ),
              verticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  genderImage(image: ic_boy, gender: gender),
                  genderSelection(
                    value: gender,
                    onChanged: (val) => bloc.add(GetSignUpGenderEvent(gender: val)),
                  ),
                  genderImage(image: ic_girl, gender: !gender),
                ],
              ),
              FieldAndLabel(
                icon: icons(icon: Icons.lock, color: theme, size: 22),
                labelBackgroundColor: white,
                validationMessage: passMsg,
                labelTextStyle: defaultHomeTextStyle(color: Colors.black),
                labelValue: txt_password,
                hint: enterPassword,
                isPassword: true,
                enabled: true,
                onChanged: (value) {
                  bloc.add(GetSignUpPasswordEvent(password: value));
                  bloc.add(GetSignUpButtonStatusEvent());
                },
              ),
              verticalSpace(10),
              submitButton(
                text: signUp,
                textColor: white,
                disable: !buttonStatus,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget genderWidget = Row(
  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //   children: [
  //     genderImage(image: ic_boy, gender: gender),
  //     genderSelection(
  //       value: gender,
  //       onChanged: (val) => bloc.add(GetSignUpGenderEvent(gender: val)),
  //     ),
  //     genderImage(image: ic_girl, gender: !gender),
  //   ],
  // );
}
