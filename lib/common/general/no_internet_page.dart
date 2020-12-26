import 'package:flutter/material.dart';
import 'package:way2fitlife/common/general_widget.dart';

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: labels(text: "No internet connection available.."),
      ),
    );
  }
}
