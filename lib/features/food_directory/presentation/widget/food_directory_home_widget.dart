import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:flutter/material.dart';


Widget listTile({String label, Function onTap}) => Card(
      child: ListTile(
        title: Padding(
          padding: horizontalPadding(padding: 10),
          child: labels(text: label, textAlign: TextAlign.start, size: 16, color: theme),
        ),
        trailing: icons(icon: Icons.chevron_right, color: iconColor, size: 30),
        onTap: onTap,
      ),
      margin: horizontalPadding(padding: 10),
      shadowColor: iconColor,
      elevation: 10,
    );

