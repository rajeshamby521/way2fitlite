import 'package:connectivity/connectivity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:way2fitlife/common/general/alert_dialog.dart';
import 'package:way2fitlife/common/general/circular_progress_indicator.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/home/presentation/widget/home_widget.dart';
import 'package:way2fitlife/features/login/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/login/presentation/widget/login_widget.dart';
import 'package:way2fitlife/features/register_page/presentation/pages/register.dart';
import 'package:way2fitlife/main.dart';
import 'package:way2fitlife/network/internet_connectivity.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/ui_helper/text_style.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  Bloc bloc = getIt<LogInBloc>();

  bool buttonStatus = false;

  String emailMsg = "Please Enter your Email";

  String passMsg = "Please Enter your Password";

  bool isLoading = false;

  @override
  Future<void> initState() {
    // MyConnectivity.checkInternet(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Scr.setScreenSize(context);
    return SafeArea(
      child: Scaffold(
        body: BlocListener(
          cubit: bloc,
          listener: (BuildContext context, state) {
            if (state is LoadingBeginHomeState) isLoading = true;
            if (state is LoadingEndHomeState) isLoading = false;
            if (state is GetLogInButtonStatusState) {
              buttonStatus = state.errorStatusModel.buttonStatus;
              emailMsg = state.errorStatusModel.emailMsg;
              passMsg = state.errorStatusModel.passMsg;
            }
            if (state is GetLogInState) {
              if (state.logInModel.flag == 1) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              }
              Fluttertoast.showToast(msg: state.logInModel.msg);
            }
          },
          child: BlocBuilder(
            cubit: bloc,
            builder: (context, state) => Container(
              height: height,
              decoration: boxDecoration(
                image: bg_home_screen2,
              ),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        skipButton(context),
                        Container(height: Scr.screenHeight * 0.25, child: animatorLogo()),
                        LogInCard(
                          context,
                          bloc: bloc,
                          buttonStatus: buttonStatus,
                          emailMsg: emailMsg,
                          passMsg: passMsg,
                        ),
                        Align(
                          child: RichText(
                            text: TextSpan(text: "Don't Have Account?   ", children: [
                              TextSpan(
                                  text: "Register",
                                  style: defaultHomeTextStyle(color: headerColor, size: 18),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      (MyConnectivity.internetStatus == internet_connected)
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Register(),
                                              ),
                                            )
                                          : internetAlertDialog(context);
                                    }),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    if (isLoading) screenProgressIndicator
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
