import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/dashboard/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/icons.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/ui_helper/text_style.dart';
import 'package:way2fitlife/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget appbar({Bloc bloc, String title, String bottomInfo, BuildContext context}) {
  return AppBar(
    backgroundColor: headerColor,
    automaticallyImplyLeading: false,
    title: Container(
      height: height * 0.1,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              child: imageAsset(img: ic_menubar, height: 34, width: 34, color: white),
              onTap: () => bloc.add(AnimatePageEvent(animate: !DashBoardScreen.animate)),
            ),
          ),
          Center(child: Text(title, textAlign: TextAlign.center)),
          if (bottomInfo != null)
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                  child: icons(icon: Icons.info, color: white),
                  onTap: () {
                    if (DashBoardScreen.animate != false)
                      bottomSheetWidget(context: context, bottomInfo: bottomInfo);
                  }),
            ),
        ],
      ),
    ),
  );
}

bottomSheetWidget({BuildContext context, String bottomInfo}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                labels(text: whatIsBMR, color: green800, size: 20),
                verticalSpace(10),
                Text(
                  bottomInfo,
                  textAlign: TextAlign.justify,
                  style: defaultHomeTextStyle(size: 18, color: black),
                ),
              ],
            ),
          ),
        );
      });
}
