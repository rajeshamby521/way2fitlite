import 'dart:math';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/current_bmr/presentation/bloc/bloc.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/ui_helper/text_style.dart';
import 'package:way2fitlife/utils/screen_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget raisedButton({String label, Function onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        color: white,
      ),
      child: Center(child: labels(text: label, size: Scr.screenHeight * 0.02, color: theme)),
    ),
  );
}

Widget calculateBMR({double bmrAns}) => Center(
      child: decoratedContainer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.2, vertical: height * 0.01),
          child: labels(
            text: bmr + " : " + roundDouble(bmrAns, 2).toString(),
            color: theme,
            size: height * 0.02,
          ),
        ),
      ),
    );

Widget calculateCalories({double calories}) => Padding(
      padding: EdgeInsets.only(left: width * 0.02, top: height * 0.01),
      child: labels(text: "${calories.round()} $calorie", color: black54, size: 20),
    );

Widget activityLabel(label) => Padding(
      padding: EdgeInsets.only(left: width * 0.05, top: height * 0.01),
      child: Align(
        child: Text(label, style: defaultHomeTextStyle(color: white, size: 18)),
        alignment: Alignment.centerLeft,
      ),
    );

roundDouble(double bmrAns, int i) => ((bmrAns * pow(10.0, i)).round().toDouble() / pow(10.0, i));

class ActivityLevel extends StatelessWidget {
  Bloc bloc;
  double bmr;
  String activityLevelMode;

  ActivityLevel({this.bloc, this.bmr, this.activityLevelMode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: roundedRectangleBorder(side: BorderSide(color: theme, width: 1), radius: 10),
        color: white,
        child: Column(
          children: [
            labelOfActivity(label: normal, description: normalActivity),
            labelOfActivity(label: light, description: lightActivity),
            labelOfActivity(label: medium, description: mediumActivity),
            labelOfActivity(label: active, description: dailyActivity)
          ],
        ),
      ),
    );
  }

  Function onChanged() {
    return (val) {
      bloc.add(CalculateCaloriesEvent(bmr: bmr, activity: val));
      bloc.add(SelectActivityEvent(activity: val));
    };
  }

  Widget labelOfActivity({String label, String description}) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.02),
      child: Row(
        children: [
          Expanded(child: Text(label), flex: 1),
          Expanded(child: Text(" : " + description), flex: 4),
          Expanded(
            child: radio(
              value: label,
              groupValue: activityLevelMode,
              onChanged: onChanged(),
              activeColor: theme,
            ),
          ),
        ],
      ),
    );
  }
}

class WeightManagement extends StatelessWidget {
  double calories;

  WeightManagement({this.calories});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: card(label: weightLoss, color: red700, calories: -500 + calories)),
        Expanded(child: card(label: maintain, color: Colors.yellow[800], calories: calories)),
        Expanded(child: card(label: weightGain, color: green300, calories: 500 + calories)),
      ],
    );
  }

  Widget card({String label, Color color, double calories}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: color,
        shape: roundedRectangleBorder(radius: 10, side: BorderSide(color: black)),
        child: AspectRatio(
          aspectRatio: 1.2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label),
                verticalSpace(height * 0.01),
                Text(calories.round().toString()),
                verticalSpace(height * 0.01),
                Text(calorie, style: defaultHomeTextStyle(color: white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}