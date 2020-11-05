import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/current_bmi/presentation/widget/meter_builder.dart';
import 'package:way2fitlife/features/current_bmr/presentation/widget/current_bmr_widget.dart';
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
  double weightKg = 60;
  double heightCm = 150;
  double bmr = 0.00;
  double calculation = 0.0;
  bool btnStatus = false;

  final bloc = getIt<CurrentBMIBloc>();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentBMIBloc, BmiState>(
      cubit: bloc,
      listener: (context, state) {
        if (state is BmiErrorState) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
        } else if (state is BmiDataState) {
          calculation = state.bmiDataModel;
          btnStatus = state.ena;
        } else {
          btnStatus = false;
          calculation = 0.0;
        }
      },
      child: BlocBuilder<CurrentBMIBloc, BmiState>(
        cubit: bloc,
        builder: (context, state) {
          return SafeArea(
              child: Scaffold(
                  appBar: appbar(
                    bloc: widget.bloc,
                    title: bmi,
                    bottmInfoTitle: whatIsBMR,
                    bottomInfo: bottomSheetBmr,
                    context: context,
                  ),
                  body: Container(
                    alignment: Alignment.centerLeft,
                    height: Scr.screenHeight,
                    width: Scr.screenWidth,
                    decoration: boxDecoration(
                      color: Colors.transparent,
                      image: bg_bmr_bmi,
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        height: Scr.screenHeight,
                        width: Scr.screenWidth,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Colors.white,
                              theme,
                            ],
                          ),
                        ),
                        child: Wrap(
                          runSpacing: 30.0,
                          children: [
                            buildForm(),
                            buildMeter(calculation),
                            bmiBuild(calculation),
                          ],
                        ),
                      ),
                    ),
                  )));
        },
      ),
    );
  }

  Widget buildForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              gradientStart,
              gradientEnd,
            ],
          ),
        ),
        child: Column(
          children: [
            verticalSpace(Scr.screenHeight * 0.03),
            Row(
              children: [
                Expanded(
                  child: pickerWithLabel(
                    labelText: weight_kg,
                    measure: kg,
                    startValue: 10,
                    endValue: 150,
                    initialItem: 50,
                    onItemChanged: (val) =>
                        weightKg = double.parse((val + 10).toString()),
                  ),
                ),
                Expanded(
                  child: pickerWithLabel(
                    labelText: height_cm,
                    measure: cm,
                    startValue: 50,
                    endValue: 200,
                    initialItem: 100,
                    onItemChanged: (val) =>
                        heightCm = double.parse((val + 50).toString()),
                  ),
                ),
              ],
            ),
            verticalSpace(Scr.screenHeight * 0.03),
            raisedButton(
              label: calculate,
              onPressed: () => bloc.add(
                BmiDataFetchEvent(
                  weight: weightKg,
                  height: heightCm,
                ),
              ),
            ),
          ],
        ),
      ),
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
                  child: 0.0 <= model
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
                  child: 18.5 <= model
                      ? model < 25.0
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
                  child: 25.0 <= model
                      ? model < 30.0
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
            children: [
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
                      0.0 < _bmr
                          ? _bmr < 18.5
                              ? underWeight
                              : _bmr < 25.0
                                  ? normal
                                  : _bmr < 30.0
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
            style: TextStyle(fontSize: 18, color: white),
          ),
        )
      ],
    );
  }

  Widget buildwidget(double model, bool enabel) {
    return SingleChildScrollView(
      child: Container(),
    );
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
