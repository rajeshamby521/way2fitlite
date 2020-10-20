import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:flutter/material.dart';

Widget submitButton({String text, Color textColor, Function onPressed, bool disable = true}) {
  return RaisedButton(
    shape: roundedRectangleBorder(radius: 10, side: BorderSide.none),
    color: headerColor,
    child: labels(text: text, color: textColor),
    onPressed: !disable ? onPressed : null,
  );
}

Widget logInButton({Widget child, Function onPressed, bool disable = true}) {
  return RaisedButton(
    shape: roundedRectangleBorder(radius: 10),
    color: theme,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    ),
    onPressed: !disable ? onPressed : null,
  );
}
