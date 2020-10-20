import 'package:flutter/cupertino.dart';

abstract class BmiEvent {}

class BmiInitialEvent extends BmiEvent {
  final bool enabel;

  BmiInitialEvent({@required this.enabel});
}

class BmiDataFetchEvent extends BmiEvent {
  final String weight;
  final String height;

  BmiDataFetchEvent({@required this.weight, @required this.height});
}
