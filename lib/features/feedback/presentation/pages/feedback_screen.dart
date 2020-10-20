import 'package:way2fitlife/common/general/appbar_widget.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/feedback/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/feedback/presentation/widget/feedback_widget.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

String sub = "";
String msg = "";

class FeedbackScreen extends StatelessWidget {
  final Bloc bloc;

  FeedbackScreen({this.bloc});

  final Bloc feedbackBloc = getIt<FeedbackBloc>();
  String subErr = "";
  String msgErr = "";
  bool buttonStatus = false;
  TextEditingController txtSubController = TextEditingController();
  TextEditingController txtMsgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(bloc: bloc, title: feedback),
      body: SafeArea(
        child: BlocListener(
          cubit: feedbackBloc,
          listener: (context, state) {
            if (state is GiveFeedbackState) {
              txtSubController.clear();
              txtMsgController.clear();
              Fluttertoast.showToast(msg: state.data.msg);
            }
            if (state is GetFeedbackButtonStatusState) {
              buttonStatus = state.errorStatusModel.buttonStatus;
              print(buttonStatus);
            }
          },
          child: BlocBuilder(
            cubit: feedbackBloc,
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              textField(
                                  label: submit,
                                  hint: enter_subject,
                                  validationMessage: subErr,
                                  controller: txtSubController,
                                  onchange: (value) {
                                    sub = value;
                                    print(sub + "   " + msg);
                                    feedbackBloc.add(GetFeedbackButtonStatusEvent(
                                      subject: sub,
                                      message: msg,
                                    ));
                                  }),
                              verticalSpace(10),
                              textField(
                                label: message,
                                hint: enter_message,
                                validationMessage: msgErr,
                                controller: txtMsgController,
                                onchange: (value) {
                                  msg = value;
                                  feedbackBloc.add(GetFeedbackButtonStatusEvent(
                                    subject: sub,
                                    message: msg,
                                  ));
                                },
                              ),
                              submitFeedbackButton(
                                status: buttonStatus,
                                onPress: () {
                                  feedbackBloc.add(GiveFeedbackEvent(subject: sub, msg: msg));
                                },
                              ),
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
