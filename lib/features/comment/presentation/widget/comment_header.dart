import 'package:flutter/material.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/ui_helper/colors.dart';

class CommentHeader extends StatelessWidget {
  String topic;
  String title;
  String desc;
  String date;

  CommentHeader({this.topic, this.title, this.desc, this.date});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              labels(
                text: topic,
                color: theme,
                size: 16,
                textAlign: TextAlign.start,
              ),
              verticalSpace(5),
              labels(
                text: title,
                color: lightTheme,
                size: 14,
                textAlign: TextAlign.start,
              ),
              verticalSpace(5),
              labels(
                text: desc,
                color: grey,
                size: 12,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: labels(text: date),
          ),
        ),
      ],
    );
  }
}
