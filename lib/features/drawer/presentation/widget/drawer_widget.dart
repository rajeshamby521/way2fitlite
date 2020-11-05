import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:way2fitlife/common/general/alert_dialog.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:way2fitlife/features/drawer/presentation/bloc/drawer_event.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/icons.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/app_preference.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

class DrawerList extends StatefulWidget {
  final Bloc bloc;

  DrawerList({this.bloc});

  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  String userId;

  @override
  void initState() {
    super.initState();
    getid();
  }

  void getid()  {
    userId =  AppPreference.getString(user_id);
    print("user id--->${userId}");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          drawerItem(context: context, icon: ic_home, label: home, pageNo: 0),
          drawerItem(
              context: context, icon: ic_bmi, label: current_bmi, pageNo: 1),
          drawerItem(
              context: context, icon: ic_bmr, label: current_bmr, pageNo: 2),
          drawerItem(
              context: context,
              icon: ic_weight,
              label: weight_sheet,
              pageNo: 3),
          drawerItem(context: context, icon: ic_chart, label: chart, pageNo: 8),
          drawerItem(
              context: context,
              icon: ic_food,
              label: food_directory,
              pageNo: 4),
          drawerItem(
              context: context,
              icon: ic_food,
              label: food_instructions,
              pageNo: 5),
          drawerItem(
              context: context, icon: ic_video, label: videos, pageNo: 6),
          drawerItem(
              context: context,
              icon: ic_gallery,
              label: photo_gallery,
              pageNo: 7),
          drawerItem(context: context, icon: ic_chart, label: chart, pageNo: 8),
          /*drawerItem(
              context: context, icon: ic_compare, label: compare, pageNo: 9),*/
           drawerItem(
              context: context, icon: ic_forum, label: forum, pageNo: 10),
          drawerItem(
              context: context, icon: ic_feedback, label: feedback, pageNo: 11),
          drawerItem(
              context: context, icon: ic_share, label: share_app, pageNo: 12),
          if (userId != null)
            drawerItem(
                context: context, icon: ic_logout, label: logout, pageNo: 13),
        ],
      ),
    );
  }

  Widget drawerItem(
      {String icon, String label, int pageNo, BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Card(
          child: Container(
            height: 100,
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                imageAsset(img: icon, color: iconColor, height: 40, width: 40),
                verticalSpace(10),
                labels(text: label, size: 14, color: theme),
              ],
            ),
          ),
        ),
        onTap: () async {
          DashBoardScreen.animate = true;

          if (pageNo == 13) {
            userId != null
                ? logoutAlertDialog(context)
                : noLoginAlertDialog(context);
          } else if (pageNo == 12) {
            Share.share(
              Platform.isIOS
                  ? "Hey, Please install this amazing app which helps to track fitness and provide good nutritional information."
                  : "Hey, Please install this amazing app which helps to track fitness and provide good nutritional information."
                      "https://play.google.com/store/apps/details?id=com.way2fitlife",
              //https://play.google.com/store/apps/details?id=com.way2fitlife
            );
          } else {
            (userId != null || pageNo <= 2)
                ? widget.bloc.add(FetchSelectPageEvent(pageNo: pageNo))
                : noLoginAlertDialog(context);
          }
        },
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  String image;

  ProfileImage({this.image});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: InkWell(
            child: Hero(
              tag: image,
              child: imageNetwork(
                img: image,
                height: height,
                width: width,
              ),
            ),
            onTap: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}
