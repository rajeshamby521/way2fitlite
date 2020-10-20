import 'dart:io';

import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/text_style.dart';
import 'package:way2fitlife/utils/screen_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget horizontalSpace(double width) => SizedBox(width: width);

Widget verticalSpace(double height) => SizedBox(height: height);

Widget space({double height, double width}) => SizedBox(height: height, width: width);

Widget icons({@required IconData icon, Color color, double size}) =>
    Icon(icon, color: color ?? white, size: size ?? 24);

BoxShadow boxShadow({double radius, Color color}) => BoxShadow(blurRadius: radius, color: color);

BoxDecoration boxDecoration({Color color, String image, ColorFilter colorFilter}) => BoxDecoration(
      color: color,
      boxShadow: [boxShadow(radius: 50, color: green100), boxShadow(radius: 50, color: black)],
      image: DecorationImage(fit: BoxFit.fill, image: assetsImage(image), colorFilter: colorFilter),
    );

Widget divider({Color color, double thickness}) => Divider(color: color, thickness: thickness);

Widget imageAsset({String img, double width, double height, Color color}) =>
    Image.asset(img, width: width, height: height, color: color, fit: BoxFit.fill);

ImageProvider assetsImage(String img) => AssetImage(img);

ImageProvider networkImage(String img) => NetworkImage(img);

Widget imageNetwork({String img, double width, double height, Color color}) =>
    Image.network(img, width: width, height: height, color: color, fit: BoxFit.fill);

Widget imageFile({File img, double width, double height, Color color}) =>
    Image.file(img, width: width, height: height, color: color, fit: BoxFit.fill);

Widget radio({String value, String groupValue, Function onChanged, Color activeColor}) =>
    Radio(value: value, groupValue: groupValue, onChanged: onChanged, activeColor: activeColor);

Widget decoratedContainer({Widget child}) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: white,
        boxShadow: [BoxShadow(blurRadius: 10, color: lightTheme, spreadRadius: 5)],
      ),
      child: child,
    );

Widget labels({@required String text, Color color, double size, TextAlign textAlign}) => Text(text,
    style: defaultDrawerLabelTextStyle(color: color, size: size),
    textAlign: textAlign ?? TextAlign.center);

RoundedRectangleBorder roundedRectangleBorder({@required double radius, BorderSide side}) =>
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius), side: side ?? BorderSide());

Widget listDivider({double padding}) => Padding(
    padding: horizontalPadding(padding: padding), child: divider(color: theme, thickness: 1));

EdgeInsetsGeometry horizontalPadding({double padding}) => EdgeInsets.symmetric(horizontal: padding);

EdgeInsetsGeometry verticalPadding({double padding}) => EdgeInsets.symmetric(vertical: padding);

Widget extendedFloatingButton({
  BuildContext context,
  Bloc bloc,
  Widget dialogContent,
  Color iconLabelColor,
  Color backgroundColor,
  IconData icon,
  String label,
}) {
  return FloatingActionButton.extended(
    onPressed: () {
      showDialog(
        context: context,
        child: AlertDialog(
          shape: roundedRectangleBorder(radius: 15),
          content: dialogContent,
        ),
      );
    },
    icon: icons(icon: icon, color: iconLabelColor),
    backgroundColor: backgroundColor,
    label: labels(text: label, color: iconLabelColor),
  );
}

Widget pickerWithLabel(
    {int startValue,
    int endValue,
    String labelText,
    String measure,
    int initialItem,
    Function onItemChanged}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      labels(text: labelText, color: theme, size: 14),
      Expanded(
        child: picker(
          startValue: startValue,
          endValue: endValue,
          measure: measure,
          initialItem: initialItem,
          onItemChanged: onItemChanged,
        ),
      ),
    ],
  );
}

Widget picker(
    {int startValue, int endValue, String measure, int initialItem, Function onItemChanged}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: height * 0.1,
      // width: width * 0.2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: CupertinoPicker(
        itemExtent: 30,
        scrollController: FixedExtentScrollController(initialItem: initialItem),
        onSelectedItemChanged: onItemChanged,
        children: [
          for (int i = startValue; i <= endValue; i++)
            Container(
              child: Center(
                child: Text(
                  i.toString() + "  $measure",
                  style: defaultHomeTextStyle(color: theme, size: 14),
                ),
              ),
              color: white,
            ),
        ],
      ),
    ),
  );
}

/*
Widget textFieldBuilder({String hint, TextEditingController controller, String suffix}) {
  return Padding(
    padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03, top: height * 0.01),
    child: TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: defaultHomeTextStyle(size: height * 0.02, color: black54),
          errorStyle: defaultHomeTextStyle(size: height * 0.02),
          fillColor: white,
          filled: true,
          prefixIcon:
              imageAsset(img: suffix, width: height * 0.02, height: height * 0.02, color: theme),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black54, width: 2)),
          contentPadding: const EdgeInsets.all(3.0),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
    ),
  );
}
*/
