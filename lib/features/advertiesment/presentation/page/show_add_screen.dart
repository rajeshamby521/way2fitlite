import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:way2fitlife/features/advertiesment/presentation/page/ad_manager.dart';

class ShowAddScreen extends StatefulWidget {
  @override
  _ShowAddScreenState createState() => _ShowAddScreenState();
}

class _ShowAddScreenState extends State<ShowAddScreen> {
  bool isRewardReady;

  void _loadRewarAd() {
    RewardedVideoAd.instance.load(
      adUnitId: AdManager.rewardedAdUnitId,
      targetingInfo: MobileAdTargetingInfo(),
    );
  }

  void _onRewardEvent(RewardedVideoAdEvent event,
      {String rewardType, int rewardAmount}) {
    switch (event) {
      case RewardedVideoAdEvent.loaded:
        isRewardReady = true;
        break;
      case RewardedVideoAdEvent.closed:
        isRewardReady = false;
        _loadRewarAd();
        Navigator.of(context).pop();
        break;
      case RewardedVideoAdEvent.failedToLoad:
        isRewardReady = false;
        break;
      case RewardedVideoAdEvent.rewarded:
        Navigator.of(context).pop();
        break;
      default:
      //do Nothing
    }
  }

  @override
  void initState() {
    super.initState();
    isRewardReady = false;
    RewardedVideoAd.instance.listener = _onRewardEvent;
    _loadRewarAd();
    RewardedVideoAd.instance.show();
  }

  Future<void> escape() async {
    await Future.delayed(Duration(seconds: 5));
    Fluttertoast.showToast(msg: "ad can't lodaded");
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    RewardedVideoAd.instance.listener = null;
  }

  @override
  Widget build(BuildContext context) {
    escape();
    return Container();
  }
}
