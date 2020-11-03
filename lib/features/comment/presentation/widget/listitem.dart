import 'package:flutter/material.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/ui_helper/icons.dart';

class ListItem extends StatelessWidget {
  String title;
  String date;
  String commentText;
  String profileImg;

  ListItem({this.title, this.profileImg = "", this.commentText, this.date});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: profileImg != ""
            ? networkImage(profileImg)
            : assetsImage(user_placeholder),
      ),
      subtitle: Text(
        commentText,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }
}
