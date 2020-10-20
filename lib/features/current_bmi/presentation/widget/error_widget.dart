import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ErrorWidget extends StatelessWidget {

  String msg;

  ErrorWidget(this.msg);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        msg,
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
