import 'dart:ui';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:animator/animator.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/ui_helper/text_style.dart';
import 'package:way2fitlife/utils/screen_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget animatorScreen({List<String> homeDataList, bool enable}) {
  return ScaleAnimatedWidget(
    enabled: enable,
    duration: Duration(milliseconds: 400),
    values: [0.7, 1],
    child: Container(
      alignment: Alignment.centerLeft,
      height: Scr.screenHeight,
      width: Scr.screenWidth,
      decoration: BoxDecoration(
        color: black,
        boxShadow: [
          boxShadow(radius: 50, color: green100),
          boxShadow(radius: 50, color: black),
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: assetsImage(bg_home_screen),
          colorFilter: ColorFilter.mode(black.withOpacity(0.8), BlendMode.dstATop),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: Scr.screenHeight * 0.25,
            child: Padding(
              padding: EdgeInsets.only(top: Scr.screenHeight * 0.05),
              child: animatorLogo(),
            ),
          ),
          verticalSpace(Scr.screenHeight * 0.03),
          divider(color: white24, thickness: 2),
          Expanded(child: dataList(homeDataList)),
        ],
      ),
    ),
  );
}

Widget logoImage({String image, double height, double width}) => Image(
      image: assetsImage(image),
      height: height,
      width: width,
      fit: BoxFit.fill,
    );

Widget animatorLogo() => Animator<double>(
      tween: Tween<double>(begin: Scr.screenHeight * 0.17, end: Scr.screenHeight * 0.2),
      cycles: 0,
      builder: (context, animatorState, child) => Center(
        child: Container(
          height: animatorState.value * 1.2,
          width: animatorState.value * 1.5,
          child: Opacity(
            opacity: 1,
            child: logoImage(
              image: appLogo,
            ),
          ),
        ),
      ),
    );

Widget dataList(List<String> data) {
  double width = Scr.screenWidth * 0.05;
  return ListView.separated(
    itemCount: data.length,
    itemBuilder: (context, index) => homeListItem(index, data[index]),
    separatorBuilder: (BuildContext context, int index) => Padding(
      padding: EdgeInsets.symmetric(horizontal: width),
      child: divider(color: white24, thickness: 2),
    ),
  );
}

Widget homeListItem(int index, text) {
  double width = Scr.screenWidth * 0.15;
  double height = Scr.screenHeight * 0.07;
  return Row(
    children: [
      index % 2 == 0
          ? logoImage(image: logo_left_side, width: width, height: height)
          : horizontalSpace(Scr.screenWidth * 0.04),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: listText(text, index),
        ),
      ),
      index % 2 != 0
          ? logoImage(image: logo_right_side, width: width, height: height)
          : horizontalSpace(Scr.screenWidth * 0.04),
    ],
  );
}

Widget listText(String text, int index) => Text(
      text,
      style: defaultHomeTextStyle(color: white, size: Scr.screenHeight * 0.02),
      overflow: TextOverflow.visible,
      textAlign: index % 2 != 0 ? TextAlign.right : TextAlign.left,
    );
