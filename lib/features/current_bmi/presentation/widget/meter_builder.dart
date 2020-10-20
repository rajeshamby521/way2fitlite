import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MeterBuilder extends StatelessWidget {
  String cat;
  String val;

  MeterBuilder({this.cat, this.val});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Text(
              cat,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          Center(
            child: Container(
              height: 2,
              width: 50,
              decoration: BoxDecoration(
                color: theme,
              ),
            ),
          ),
          Center(
            child: Text(
              val,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
