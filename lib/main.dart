import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:way2fitlife/features/drawer/presentation/pages/drawer_screen.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:way2fitlife/features/home/presentation/widget/home_widget.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/login/presentation/pages/login_screen.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/app_preference.dart';
import 'package:way2fitlife/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/drawer/presentation/bloc/bloc.dart';

import 'dart:io' show Platform;

Future<String> _getToken() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor;
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId;
  }
}

String userId = "";

setUpAll() async {
  WidgetsFlutterBinding.ensureInitialized();
  initGetServiceLocator();
  AppPreference.init();
  String deviceToken = await _getToken();
  AppPreference.set(device_token, deviceToken);
  userId = AppPreference.getString(user_id);
}

Future<void> main() async {
  await setUpAll();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: way2fitlife,
      theme: ThemeData(cursorColor: theme, primaryColor: theme),
      home: userId == null ? LogInScreen() : MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int page;
  final bloc = getIt<DrawerBloc>();
  bool isLoading = true;
  UserData userDetails = UserData();

  @override
  void initState() {
    if (AppPreference.getString(userData) != null) {
      userDetails = UserData.fromMap(jsonDecode(AppPreference.getString(userData)));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Scr.setScreenSize(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // bloc.add(FetchSelectPageEvent(pageNo: 0));
    return Scaffold(
      backgroundColor: home_background,
      body: SafeArea(
        child: BlocListener(
          cubit: bloc,
          listener: (BuildContext context, state) {
            if (state is LoadingBeginHomeState) {
              isLoading = true;
            } else if (state is LoadingEndHomeState) {
              isLoading = false;
            } else if (state is FetchSelectPageState) {
              page = state.pageNo;
            }
          },
          child: BlocBuilder(
            cubit: bloc,
            builder: (BuildContext context, state) {
              // return LogInScreen();
              return Stack(
                children: [
                  Container(
                    child: logoImage(
                      image: bg_login,
                      height: Scr.infinite,
                      width: Scr.infinite,
                    ),
                  ),
                  CustomDrawer(bloc: bloc, userData: userDetails),
                  DashBoardScreen(pageNo: page),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
