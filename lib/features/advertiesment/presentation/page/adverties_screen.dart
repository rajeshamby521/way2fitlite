import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:way2fitlife/common/general/appbar_widget.dart';
import 'package:way2fitlife/features/advertiesment/presentation/page/ad_manager.dart';
import 'package:way2fitlife/features/advertiesment/presentation/page/show_add_screen.dart';
import 'package:way2fitlife/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

class AdvertiesScreen extends StatefulWidget {
  final Bloc bloc;

  AdvertiesScreen({this.bloc});

  @override
  _AdvertiesScreenState createState() => _AdvertiesScreenState();
}

class _AdvertiesScreenState extends State<AdvertiesScreen> {
  BannerAd _bannerAd;
  double size1;

  InterstitialAd _interstitialAd;
  bool isInterstitalReady;

  final _controller = NativeAdmobController();

  void _loadBannerAd() {
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.bottom);
  }

  void _loadInterstitialAd() {
    _interstitialAd.load();
  }

  void _onInterstitialEvent(MobileAdEvent event) {
    switch (event) {
      case MobileAdEvent.loaded:
        isInterstitalReady = true;
        break;
      case MobileAdEvent.failedToLoad:
        isInterstitalReady = false;
        break;
      case MobileAdEvent.closed:
        //do nothing
        break;
      default:
      //do nothing
    }
  }

  @override
  void initState() {
    super.initState();
    isInterstitalReady = false;
    _bannerAd =
        BannerAd(adUnitId: AdManager.bannerAdUnitId, size: AdSize.banner);
    _interstitialAd = InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: _onInterstitialEvent,
    );
    _loadBannerAd();
    _loadInterstitialAd();
    _interstitialAd.show();
    getRewaredeAd();
  }

  Future<void> getRewaredeAd() async {
    await Future.delayed(Duration(seconds: 10));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ShowAddScreen()));
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _interstitialAd.show();
    print("dashhshshhshs-->${DashBoardScreen.animate}");
    if (DashBoardScreen.animate == false) {
      _bannerAd?.dispose();
    }
    return Scaffold(
      appBar: appbar(bloc: widget.bloc, title: feedback),
      body: SafeArea(
        child: FutureBuilder(
          future: _initAdMob(),
          builder: (context, snapshot) => Container(
            height: Scr.screenHeight,
            width: Scr.screenWidth,
            color: green,
            child: Wrap(
              children: [
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      print("balabla");
                    },
                    child: Text("ad"),
                  ),
                ),
                Container(
                  height: 300,
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: NativeAdmob(
                    adUnitID: AdManager.nativeAdUnitId,
                    // numberAds: 3,
                    controller: _controller,
                    type: NativeAdmobType.full,
                    options: NativeAdmobOptions(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }
}
