import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/login/presentation/pages/login_screen.dart';
import 'package:way2fitlife/features/logout/logout_api_alert.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/utils/app_preference.dart';
import 'package:flutter/material.dart';

noLoginAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    child: AlertDialog(
      shape: roundedRectangleBorder(radius: 15),
      title: labels(text: "way2fitlife", color: theme, textAlign: TextAlign.start),
      content: labels(text: "You have to Login to Continue.", textAlign: TextAlign.start),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: labels(text: "Cancel", color: theme),
        ),
        FlatButton(
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LogInScreen()),
            (Route<dynamic> route) => false,
          ),
          child: labels(text: "Ok", color: theme),
        ),
      ],
    ),
  );
}

void logoutAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    child: AlertDialog(
      shape: roundedRectangleBorder(radius: 15),
      title: labels(text: "way2fitlife", color: theme, textAlign: TextAlign.start),
      content: labels(text: "Are you sure to Logout?", textAlign: TextAlign.start),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: labels(text: "Cancel", color: theme),
        ),
        FlatButton(
          onPressed: ()  {
             logOut(context);
          },
          child: labels(text: "Ok", color: theme),
        ),
      ],
    ),
  );
}
