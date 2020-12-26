import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:way2fitlife/common/general/alert_dialog.dart';
import 'package:way2fitlife/ui_helper/strings.dart';

class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else
        isOnline = false;
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();

  static String internetStatus = "";

  static checkInternet(context) async {
    MyConnectivity _connectivity = MyConnectivity.instance;
    _connectivity.initialise();
    _connectivity.myStream.listen((source) async {
      switch (source.keys.toList()[0]) {
        case ConnectivityResult.none:
          print(" * * * * * * * * Offline");
          await internetAlertDialog(context);
          internetStatus = no_internet;
          break;
        case ConnectivityResult.mobile:
          print(" * * * * * * * * Mobile: Online");
          internetStatus = internet_connected;
          break;
        case ConnectivityResult.wifi:
          print(" * * * * * * * * WiFi: Online");
          internetStatus = internet_connected;
          break;
      }
    });
  }
}
