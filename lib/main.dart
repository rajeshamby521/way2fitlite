import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:way2fitlife/features/drawer/presentation/pages/drawer_screen.dart';
import 'package:way2fitlife/features/home/presentation/widget/home_widget.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/login/presentation/pages/login_screen.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/network/internet_connectivity.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/app_preference.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

import 'features/advertiesment/presentation/page/ad_manager.dart';
import 'features/drawer/presentation/bloc/bloc.dart';

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

String userId = '';

InterstitialAd interstitialAd;
BannerAd _bannerAd;
bool isInterstitialReady = false;
bool isBannerReady = false;

Future<void> initAdMob() {
  FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  // RequestConfiguration.Builder().setTestDeviceIds(Arrays.asList("2A7D8394FB6369ED56FE41B58EEBC898")
}




setUpAll() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initGetServiceLocator();
  initAdMob();
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

/*class FirebaseInit extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
       */ /* if (snapshot.hasError) {
          return SomethingWentWrong();
        }*/ /*

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return userId == null ? LogInScreen() : MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return screenProgressIndicator;
      },
    );
  }
}*/

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
    MyConnectivity.checkInternet(context);
    if (AppPreference.getString(userData) != null) {
      userDetails =
          UserData.fromJson(jsonDecode(AppPreference.getString(userData)));
    }
    initBannerAd();
    loadBannerAd();

    _initInterAd();
    _loadInterstitialAd();

    super.initState();
  }

  //_bannerAd.show(anchorType: AnchorType.bottom);
  void _initInterAd() {
    interstitialAd = InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: _onInterstitialEvent,
    );
  }

  void _onInterstitialEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        isInterstitialReady = true;
        print("inter Loaded");
        break;
      case MobileAdEvent.failedToLoad:
        isInterstitialReady = false;
        print("inter Failed to Loaded");
        break;
      case MobileAdEvent.closed:
        print("inter closed");
        //do nothing
        break;
      case MobileAdEvent.opened:
        print("inter opened");
        _initInterAd();
        _loadInterstitialAd();
        break;
      default:
      //do nothing
    }
  }

  void _loadInterstitialAd() {
    interstitialAd.load();
  }

  void initBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
      listener: onBannerAdEvent,
    );
  }

  void loadBannerAd() {
    _bannerAd.load();
  }

  void onBannerAdEvent(MobileAdEvent event) {

    switch (event) {
      case MobileAdEvent.loaded:
        if(!isBannerReady)bloc.add(ShowAdEvent());
        isBannerReady = true;
        print("BannerAd Loaded");
        break;
      case MobileAdEvent.failedToLoad:
        isBannerReady = false;
        print("BannerAd Failed to Loaded");
        break;
      default:
      //do nothing
    }
  }



  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Scr.setScreenSize(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (AppPreference.getString(userData) != null) {
      userDetails =
          UserData.fromJson(jsonDecode(AppPreference.getString(userData)));
    }
    // bloc.add(FetchSelectPageEvent(pageNo: 0));
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
              } else if(state is ShowAdState){
               if(isBannerReady) _bannerAd.show(anchorType: AnchorType.bottom,);
              }
            },
            child: BlocBuilder(
              cubit: bloc,
              builder: (BuildContext context, state) {
                // return LogInScreen();
                return Container(
                  height: Scr.infinite,
                  width: Scr.infinite,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(bg_login,
                      )
                    )
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                           /* Container(
                              child: logoImage(
                                image: bg_login,
                                height: Scr.infinite,
                                width: Scr.infinite,
                              ),
                            ),*/
                            CustomDrawer(bloc: bloc, userData: userDetails),
                            DashBoardScreen(pageNo: page),
                          ],
                        ),
                      ),
                      if(isBannerReady)Container(height: 50,color: transparent,),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    bloc.add(FetchSelectPageEvent(pageNo: 0));
  }
}
