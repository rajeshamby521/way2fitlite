import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/general/appbar_widget.dart';
import 'package:way2fitlife/common/general/gender_widget.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/current_bmr/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/current_bmr/presentation/widget/current_bmr_widget.dart';
import 'package:way2fitlife/main.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/icons.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

class CurrentBMRScreen extends StatefulWidget {
  final Bloc bloc;

  CurrentBMRScreen({this.bloc});

  @override
  _CurrentBMRScreenState createState() => _CurrentBMRScreenState();
}

class _CurrentBMRScreenState extends State<CurrentBMRScreen> {
  double ageYear = 25;
  double weightKg = 60;
  double heightCm = 150;
  double bmrAns = 0;
  double caloriesAns = 0;
  String activityMode = "";
  bool gender = false;

  final bloc = getIt<CurrentBMRBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (BuildContext context, state) {
        if (state is CalculateBMRState) bmrAns = state.bmr;
        if (state is CalculateCaloriesState) caloriesAns = state.calories;
        if (state is SelectGenderState) gender = state.gender;
        if (state is SelectActivityState) activityMode = state.activity;
      },
      child: BlocBuilder(
        cubit: bloc,
        builder: (BuildContext context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: appbar(
                bloc: widget.bloc,
                title: bmr,
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(50)),
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
                                verticalSpace(Scr.screenHeight * 0.02),
                                Row(
                                  children: [
                                    Expanded(
                                      child: pickerWithLabel(
                                        labelText: weight_kg,
                                        measure: kg,
                                        startValue: 10,
                                        endValue: 150,
                                        initialItem: 50,
                                        onItemChanged: (val) => weightKg =
                                            double.parse((val + 10).toString()),
                                      ),
                                    ),
                                    Expanded(
                                      child: pickerWithLabel(
                                        labelText: height_cm,
                                        measure: cm,
                                        startValue: 50,
                                        endValue: 200,
                                        initialItem: 100,
                                        onItemChanged: (val) => heightCm =
                                            double.parse((val + 50).toString()),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: width * 0.4,
                                  child: pickerWithLabel(
                                    labelText: age_year,
                                    measure: year,
                                    startValue: 10,
                                    endValue: 100,
                                    initialItem: 15,
                                    onItemChanged: (val) => ageYear =
                                        double.parse((val + 10).toString()),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    genderImage(image: ic_boy, gender: gender),
                                    genderSelection(
                                      value: gender,
                                      onChanged: (val) => bloc
                                          .add(SelectGenderEvent(gender: val)),
                                    ),
                                    genderImage(
                                        image: ic_girl, gender: !gender),
                                  ],
                                ),
                                verticalSpace(Scr.screenHeight * 0.02),
                                raisedButton(
                                    label: calculate,
                                    onPressed: () {
                                      bloc.add(
                                        CalculateBMREvent(
                                          age: ageYear,
                                          weight: weightKg,
                                          height: heightCm,
                                          gender: gender,
                                        ),
                                      );
                                      if (isInterstitialReady)
                                        interstitialAd.show();
                                    }),
                              ],
                            ),
                          ),
                          // child: Stack(
                          //   children: [
                          //     // imageAsset(img: bg_bmr, color: Colors.grey[400]),
                          //     Column(
                          //       children: [
                          //         textFieldBuilder(
                          //             controller: txtAgeController,
                          //             hint: age_year,
                          //             suffix: ic_birthdate),
                          //         textFieldBuilder(
                          //             controller: txtWeightController,
                          //             hint: weight_kg,
                          //             suffix: ic_weight),
                          //         textFieldBuilder(
                          //             controller: txtHeightController,
                          //             hint: height_cm,
                          //             suffix: ic_height),
                          //         verticalSpace(Scr.screenHeight * 0.02),
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Text("AGE  : "),
                          //             horizontalSpace(15),
                          //             Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Container(
                          //                 height: 70,
                          //                 width: 100,
                          //                 decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.circular(10.0),
                          //                   gradient: LinearGradient(
                          //                     begin: Alignment.topCenter,
                          //                     end: Alignment.bottomCenter,
                          //                     colors: <Color>[
                          //                       Colors.redAccent,
                          //                       Colors.deepOrange,
                          //                       Colors.deepOrangeAccent,
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 child: CupertinoPicker(
                          //                     itemExtent: 30,
                          //                     onSelectedItemChanged: (val) {
                          //                       setState(() {
                          //                         bmrAns = val.toDouble();
                          //                       });
                          //                     },
                          //                     children: [
                          //                       for (int i = 1; i <= 100; i++)
                          //                         Text(
                          //                           i.toString(),
                          //                           style: defaultHomeTextStyle(color: Colors.white),
                          //                         ),
                          //                     ]),
                          //               ),
                          //             ),
                          //             horizontalSpace(15),
                          //             Text("YEARS"),
                          //           ],
                          //         ),
                          //         SliderTheme(
                          //           data: SliderTheme.of(context).copyWith(
                          //             activeTrackColor: Colors.red[700],
                          //             inactiveTrackColor: Colors.red[100],
                          //             trackShape: RoundedRectSliderTrackShape(),
                          //             trackHeight: 4.0,
                          //             thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                          //             thumbColor: Colors.redAccent,
                          //             overlayColor: Colors.red.withAlpha(32),
                          //             overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                          //             tickMarkShape: RoundSliderTickMarkShape(),
                          //             activeTickMarkColor: Colors.red[700],
                          //             inactiveTickMarkColor: Colors.red[100],
                          //             valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                          //             valueIndicatorColor: Colors.redAccent,
                          //             valueIndicatorTextStyle: TextStyle(
                          //               color: Colors.white,
                          //             ),
                          //           ),
                          //           child: Slider(
                          //             value: bmrAns,
                          //             onChanged: (value) {
                          //               setState(() {
                          //                 bmrAns = value;
                          //               });
                          //             },
                          //             min: 0,
                          //             max: 100,
                          //             divisions: 100,
                          //             label: bmrAns.toInt().toString(),
                          //           ),
                          //         ),
                          //         Gender(),
                          //         verticalSpace(Scr.screenHeight * 0.02),
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //           children: [
                          //             raisedButton(
                          //                 label: reset,
                          //                 onPressed: () {
                          //                   txtHeightController.clear();
                          //                   txtWeightController.clear();
                          //                   txtAgeController.clear();
                          //                 }),
                          //             raisedButton(
                          //               label: calculate,
                          //               onPressed: () => bloc.add(
                          //                 CalculateBMREvent(
                          //                   age: double.parse(txtAgeController.text),
                          //                   weight: double.parse(txtWeightController.text),
                          //                   height: double.parse(txtHeightController.text),
                          //                   gender: gen,
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                        ),
                        divider(color: lightTheme, thickness: 2),
                        verticalSpace(height * 0.01),
                        calculateBMR(bmrAns: bmrAns),
                        verticalSpace(height * 0.01),
                        divider(color: lightTheme, thickness: 2),
                        activityLabel(selectActivityLevel),
                        ActivityLevel(
                            bloc: bloc,
                            bmr: bmrAns,
                            activityLevelMode: activityMode),
                        Row(
                          children: [
                            activityLabel(dailyIntake),
                            calculateCalories(calories: caloriesAns),
                          ],
                        ),
                        WeightManagement(calories: caloriesAns),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

/*show(context) => showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              bottomSheet,
              textAlign: TextAlign.justify,
              style: defaultHomeTextStyle(size: 15, color: black),
            ),
          ),
        );
      });*/
}
