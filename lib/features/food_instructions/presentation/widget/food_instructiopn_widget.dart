import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:flutter/material.dart';

Widget FoodAvoidDataList({List data}) {
  return ListView.builder(
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        leading: icons(icon: Icons.cancel, color: red700),
        title: labels(
          text: data[index].strictly,
          color: theme,
          textAlign: TextAlign.left,
        ),
      );
    },
  );
}

Widget FoodEatDataList({List data}) {
  return ListView.builder(
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        leading: icons(icon: Icons.check_circle, color: green800),
        title: labels(
          text: data[index].eat,
          color: theme,
          textAlign: TextAlign.left,
        ),
      );
    },
  );
}
