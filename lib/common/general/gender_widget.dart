

import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/utils/screen_utils.dart';
import 'package:flutter/material.dart';

Widget genderSelection({bool value, Function onChanged}) {
  return Switch(
    value: value,
    onChanged: onChanged,
    inactiveThumbColor: Colors.blue,
    activeColor: Colors.pink,
  );
}

Widget genderImage({String image, bool gender}) {
  return Stack(
    children: [
      imageAsset(img: image, height: height * 0.1, width: height * 0.1),
      if (gender) CircleAvatar(radius: height * 0.05, backgroundColor: Colors.black38),
    ],
  );
}
