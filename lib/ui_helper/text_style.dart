import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:flutter/cupertino.dart';

TextStyle defaultHomeTextStyle({Color color, double size}) =>
    TextStyle(color: color ?? white, fontSize: size);

TextStyle defaultDrawerLabelTextStyle({Color color, double size}) =>
    TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold);

TextStyle defaultLabelStyle(color, backgroundColor, {bool isReversed = false}) => TextStyle(
    fontSize: 12, fontWeight: FontWeight.w500, color: color, backgroundColor: backgroundColor);
