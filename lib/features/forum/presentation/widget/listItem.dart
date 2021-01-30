import 'package:flutter/material.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/comment/presentation/page/comment_screen.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/utils/app_preference_util.dart';class listItem extends StatelessWidget {
  String title;
  String subtitle;
  String id;

  listItem({this.title, this.subtitle, this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 20,
        shadowColor: green,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 1.0),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                color: theme,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(color: theme, fontSize: 12),
            ),
            trailing:
                icons(icon: Icons.chevron_right, size: 20, color: iconColor),
          ),
        ),
      ),
      onTap: () {
        AppPreferenceUtil().writeString(forum_id, id);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CommentScreen(
            forum_id: id,
          ),
        ));
      },
    );
  }
}
