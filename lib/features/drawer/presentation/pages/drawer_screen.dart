import 'package:way2fitlife/common/general/alert_dialog.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/drawer/presentation/widget/drawer_widget.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/icons.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  Bloc bloc;
  UserData userData;

  CustomDrawer({this.bloc, this.userData});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: Scr.infinite,
            width: Scr.screenWidth * 0.3,
            child: DrawerList(bloc: bloc),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.02, right: width * 0.02),
              child: decoratedContainer(
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: InkWell(
                          child: Hero(
                            tag: userData.profileImage ?? ic_fitness_person,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: userData.profileImage != null
                                  ? networkImage(userData.profileImage)
                                  : assetsImage(ic_fitness_person),
                            ),
                          ),
                          onTap: () {
                            if (userData.profileImage != null)
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProfileImage(
                                    image: userData.profileImage,
                                  ),
                                ),
                              );
                          },
                        ),
                        title: labels(text: userData.username ?? guest, color: theme, size: 14),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: labels(
                                text: "W : ${userData.weight ?? '--'} $kg",
                                size: 10,
                              ),
                            ),
                            Expanded(
                              child: labels(
                                text: "H : ${userData.height ?? '--'} $cm",
                                size: 10,
                              ),
                            ),
                          ],
                        ),
                        onTap: () => userData.username ?? noLoginAlertDialog(context),
                      ),
                    ),
                    if (userData.userId != null)
                      IconButton(
                        icon: icons(icon: Icons.edit, color: iconColor, size: height * 0.03),
                        onPressed: () {},
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
