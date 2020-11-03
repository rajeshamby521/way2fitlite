import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:way2fitlife/common/general/appbar_widget.dart';
import 'package:way2fitlife/common/general/buttons.dart';
import 'package:way2fitlife/common/general/field_and_label.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/feedback/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/feedback/presentation/widget/feedback_widget.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';

class FeedbackScreen extends StatefulWidget {
  final Bloc bloc;

  FeedbackScreen({this.bloc});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final Bloc feedbackBloc = getIt<FeedbackBloc>();
  String subErr = "";
  String msgErr = "";
  String sub = "";
  String msg = "";
  bool buttonStatus = false;
  TextEditingController txtSubController = TextEditingController();
  TextEditingController txtMsgController = TextEditingController();
  FocusNode txtSubFocus = FocusNode();
  FocusNode txtMsgFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    feedbackBloc.add(GetFeedbackButtonStatusEvent(
      subject: sub,
      message: msg,
    ));
  }

  @override
  void dispose() {
    txtSubController.dispose();
    txtMsgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(bloc: widget.bloc, title: feedback),
      body: SafeArea(
        child: BlocListener(
          cubit: feedbackBloc,
          listener: (context, state) {
            if (state is GiveFeedbackState) {
              txtSubController.clear();
              txtMsgController.clear();
              sub = '';
              msg = '';
              buttonStatus = false;
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
                                hint: enter_subject,
                                labelValue: subject,
                                labelTextStyle: TextStyle(fontSize: 18),
                                controller: txtSubController,
                                inputType: TextInputType.text,
                                //validationMessage: subErr,
                                inputAction: TextInputAction.next,
                                focusNode: txtSubFocus,
                                nextFocusNode: txtMsgFocus,
                                onChanged: (value) {
                                  sub = value;
                                  print(sub + "   " + msg);
                                  feedbackBloc.add(GetFeedbackButtonStatusEvent(
                                    subject: sub,
                                    message: msg,
                                  ));
                                },
                              ),
                              verticalSpace(10),
                              FieldAndLabel(
                                fieldType: FieldType.TextField,
                                enabled: true,
                                hint: enter_message,
                                labelValue: message,
                                labelTextStyle: TextStyle(fontSize: 18),
                                controller: txtMsgController,
                                inputType: TextInputType.text,
                                //validationMessage: msgErr,
                                inputAction: TextInputAction.done,
                                focusNode: txtMsgFocus,
                                nextFocusNode: null,
                                onChanged: (value) {
                                  msg = value;
                                  print(sub + "   " + msg);
                                  feedbackBloc.add(GetFeedbackButtonStatusEvent(
                                    subject: sub,
                                    message: msg,
                                  ));
                                },
                              ),
                              /*submitFeedbackButton(
                                status: buttonStatus,
                                onPress: () {

                                },
                              ),*/
                              submitButton(
                                  text: addFeedBack,
                                  textColor: white,
                                  disable: !buttonStatus,
                                  onPressed: () {
                                    feedbackBloc.add(GiveFeedbackEvent(
                                        subject: sub, msg: msg));
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
