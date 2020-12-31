import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9652075612301937~9555478129";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544~2594085930";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9652075612301937/7490575659";
      // return "ca-app-pub-3940256099942544/8865242552";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4339318960";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9652075612301937/3419468700";
      // return "ca-app-pub-9652075612301937/3419468700";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/3964253750";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9652075612301937/2649312517";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/7552160883";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      //Live
      return "ca-app-pub-9652075612301937/8480223695";
      //Test
      // return "ca-app-pub-3940256099942544/2247696110";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/8135179316";
    } else {
      throw new UnimplementedError("Unsupported Plateform");
    }
  }
}
