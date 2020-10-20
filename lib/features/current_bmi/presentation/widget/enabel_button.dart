import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EnabelButton extends StatelessWidget {
  final String name;
  double width;
  bool status;

  EnabelButton({this.name, this.width, this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: status ? headerColor : grey,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(name,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.white)),
      ),
    );
  }
}
