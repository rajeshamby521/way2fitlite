import 'package:flutter/material.dart';
import 'package:way2fitlife/features/current_bmi/presentation/widget/enabel_button.dart';

// ignore: must_be_immutable
class ButtonBuilder extends StatelessWidget {
  String name;
  bool status;
  double width;
  Function onPress;

  ButtonBuilder({this.name, this.status, this.width, this.onPress});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPress,
      textColor: Colors.white,
      color: Colors.transparent,
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: status
          ? EnabelButton(
              name: name,
              status: true,
              width: width,
            )
          : EnabelButton(
              name: name,
              status: false,
              width: width,
            ),
    );
  }
}
