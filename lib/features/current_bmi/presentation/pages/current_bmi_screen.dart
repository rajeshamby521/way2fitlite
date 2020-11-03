import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/general/field_and_label.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/current_bmi/presentation/widget/enabel_button.dart';
import 'package:way2fitlife/features/current_bmi/presentation/widget/meter_builder.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

import '../../../../common/general/appbar_widget.dart';
import '../../../../common/general_widget.dart';
import '../../../../ui_helper/images.dart';
import '../bloc/current_bmi_bloc.dart';
import '../bloc/current_bmi_event.dart';
import '../bloc/current_bmi_state.dart';

class CurrentBMIScreen extends StatefulWidget {
  final Bloc bloc;

  CurrentBMIScreen({this.bloc});

  @override
  _CurrentBMIScreenState createState() => _CurrentBMIScreenState();
}

class _CurrentBMIScreenState extends State<CurrentBMIScreen> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final yearController = TextEditingController();
  final weightFocus = FocusNode();
  final heightFocus = FocusNode();
  String height = "";
  String weight = "";
  double bmr = 0.00;

  final bloc = getIt<CurrentBMIBloc>();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    bloc.add(BmiInitialEvent(enabel: false));
    super.initState();
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        bloc: widget.bloc,
        title: bmi,
        bottomInfo: bottomSheetBmi,
        context: context,
      ),
      body: Container(
        height: double.maxFinite,
        decoration: boxDecoration(
          color: Colors.transparent,
          image: bg_login,
        ),
        child: BlocListener<CurrentBMIBloc, BmiState>(
          cubit: bloc,
          listener: (context, state) {
            if (state is BmiErrorState) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.msg)));
            } else if (state is BmiInitialState) {
              buildwidget(state.bmiDataModel, state.enabel);
            } else if (state is BmiDataState) {
              buildwidget(state.bmiDataModel, state.ena);
            } else {
              return Container();
            }
          },
          child: BlocBuilder<CurrentBMIBloc, BmiState>(
            cubit: bloc,
            builder: (context, state) {
              if (state is BmiErrorState)
                return ErrorWidget(state.msg);
              else if (state is BmiInitialState)
                return buildwidget(bmr, state.enabel);
              else if (state is BmiDataState) {
                return buildwidget(state.bmiDataModel, state.ena);
              } else
                return Container();
            },
          ),
        ),
      ),
      // bottomNavigationBar: InkWell(
      //     onTap: () {},
      //     child: Container(
      //       height: 40,
      //       color: theme,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Icon(
      //             Icons.keyboard_arrow_down,
      //             color: Colors.white,
      //             size: 40,
      //           ),
      //           Text(
      //             "Check Info",
      //             style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
      //           ),
      //         ],
      //       ),
      //     )),
    );
  }

  Widget buttonBuilder(String name, bool enable, bool c) {
    return RaisedButton(
      onPressed: () {
        c ? calculate(enable) : reset();
      },
      textColor: Colors.white,
      color: Colors.transparent,
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: c
          ? EnabelButton(
              name: name,
              status: enable,
              width: 150,
            )
          : EnabelButton(name: name, status: true, width: 150),
    );
  }

  Widget buildForm(bool enabel) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Wrap(
            runSpacing: 12.0,
            children: [
              FieldAndLabel(
                hint: "Weight",
                enabled: true,
                inputType: TextInputType.number,
                autoFocus: false,
                controller: weightController,
                inputAction: TextInputAction.next,
                focusNode: weightFocus,
                nextFocusNode: heightFocus,
                onChanged: (value) {
                  weight = value;

                  height != "" && weight != ""
                      ? bloc.add(BmiInitialEvent(enabel: true))
                      : bloc.add(BmiInitialEvent(enabel: false));
                },
              ),
              FieldAndLabel(
                hint: "Height",
                controller: heightController,
                autoFocus: false,
                inputType: TextInputType.number,
                enabled: true,
                focusNode: heightFocus,
                nextFocusNode: null,
                onChanged: (value) {
                  height = value;
                  height != "" && weight != ""
                      ? bloc.add(BmiInitialEvent(enabel: true))
                      : bloc.add(BmiInitialEvent(enabel: false));
                },
              ),

              //rest calculate button
              Container(
                height: 50,
                child: Center(
                  child: Wrap(
                    spacing: 20.0,
                    children: [
                      //reset
                      buttonBuilder('Reset', enabel, false),
                      //calculate
                      buttonBuilder('Calculate', enabel, true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildMeter(double model) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: Container(
        height: Scr.screenHeight * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //UnderWight
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MeterBuilder(cat: underWeight, val: underWeightRange),
                ),
                Container(
                  child: 0.0 < model
                      ? model < 18.5
                          ? CustomPaint(
                              size: Size(10, 10),
                              painter: DrawTrilangeShape(),
                            )
                          : Container(
                              height: 10,
                            )
                      : Container(
                          height: 10,
                        ),
                ),
              ],
            ),
            VerticalDivider(
              width: 1.0,
              indent: 0.0,
              endIndent: 0.0,
              thickness: 1.0,
              color: Colors.black,
            ),
            //Normal
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MeterBuilder(cat: normal, val: normalRange),
                ),
                Container(
                  child: 18.5 < model
                      ? model < 24.9
                          ? CustomPaint(
                              size: Size(10, 10),
                              painter: DrawTrilangeShape(),
                            )
                          : Container(
                              height: 10,
                              width: 0,
                            )
                      : Container(
                          height: 10,
                          width: 0,
                        ),
                ),
              ],
            ),
            VerticalDivider(
              width: 1.0,
              indent: 0.0,
              endIndent: 0.0,
              thickness: 1.0,
              color: Colors.black,
            ),
            //Overweight
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: MeterBuilder(cat: overWeight, val: overWeightRange)),
                Container(
                  child: 25.0 < model
                      ? model < 29.9
                          ? CustomPaint(
                              size: Size(10, 10),
                              painter: DrawTrilangeShape(),
                            )
                          : Container(
                              height: 10,
                              width: 0,
                            )
                      : Container(
                          height: 10,
                          width: 0,
                        ),
                ),
              ],
            ),
            VerticalDivider(
              width: 1.0,
              indent: 0.0,
              endIndent: 0.0,
              thickness: 1.0,
              color: Colors.black,
            ),
            //obese
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: MeterBuilder(cat: obeses, val: obesesRange)),
                Container(
                  child: model >= 30.0
                      ? CustomPaint(
                          size: Size(10, 10),
                          painter: DrawTrilangeShape(),
                        )
                      : Container(
                          height: 10,
                          width: 0,
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bmiBuild(double _bmr) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: Scr.screenWidth * 0.3,
          height: Scr.screenWidth * 0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white,
              boxShadow: [BoxShadow(blurRadius: 10, color: black54)]),
          child: Stack(
            //alignment: AlignmentDirectional.topStart,
            children: [
              // Center(child: CustomPaint(painter: MyPainter())),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      bmi,
                      style: TextStyle(
                          color: theme,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _bmr.toString().isNotEmpty ? _bmr.toString() : "0.0",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    listDivider(padding: 40),
                    Text(
                      0.1 < _bmr
                          ? _bmr < 18.5
                              ? underWeight
                              : _bmr < 24.9
                                  ? normal
                                  : _bmr < 29.9
                                      ? overWeight
                                      : obeses
                          : ' ',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        verticalSpace(20.0),
        Center(
          child: Text(
            0.1 < _bmr
                ? _bmr < 18.5
                    ? underWeightMsg
                    : _bmr < 24.9
                        ? normalMsg
                        : _bmr < 29.9
                            ? overWeightMsg
                            : obeseMsg
                : ' ',
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }

  Widget buildwidget(double model, bool enabel) {
    return Wrap(
      runSpacing: 20.0,
      children: [
        buildForm(enabel),
        buildMeter(model),
        bmiBuild(model),
      ],
    );
  }

  void calculate(bool enabel) {
    enabel
        ? bloc.add(BmiDataFetchEvent(
            weight: weightController.text,
            height: heightController.text,
          ))
        // ignore: unnecessary_statements
        : null;
  }

  void reset() {
    bloc.add(BmiInitialEvent(enabel: enabel));
    weightController.clear();
    heightController.clear();
    yearController.clear();
  }
}

class DrawTrilangeShape extends CustomPainter {
  Paint painter;

  DrawTrilangeShape() {
    painter = Paint()
      ..color = theme
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromPoints(Offset(0, 0), Offset(100, 100));
    Paint arcPaint = Paint()
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..color = theme;

    //canvas.drawArc(rect, 3*math.pi/4, 3*math.pi/4, false, arcPaint);
    canvas.drawArc(rect, (math.pi / 4) * 0.9, -4.55, false, arcPaint);
    //canvas.drawOval(rect, arcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
