import 'package:way2fitlife/common/general/field_and_label.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/ui_helper/text_style.dart';
import 'package:flutter/material.dart';

Widget textField({
  String hint,
  String label,
  String validationMessage,
  Function onchange,
  TextEditingController controller,
}) {
  return FieldAndLabel(
    hint: hint,
    labelValue: label,
    labelTextStyle: defaultHomeTextStyle(size: 18, color: theme),
    enabled: true,
    onChanged: onchange,
    validationMessage: validationMessage,
    controller: controller,
  );
}

Widget bgImg = Container(decoration: boxDecoration(image: bg_login));

Widget submitFeedbackButton({Function onPress, bool status}) => RaisedButton(
      shape: roundedRectangleBorder(radius: 10,side: BorderSide.none),
      color: iconColor,
      child: labels(text: submit, color: white),
      onPressed: status ? onPress : null,
    );
