abstract class BmiState {}

class BmiInitialState extends BmiState {
  double bmiDataModel = 0.000;
  bool enabel;

  BmiInitialState(this.bmiDataModel, this.enabel);
}

class BmiDataState extends BmiState {
  double bmiDataModel;
  bool ena;

  BmiDataState(this.bmiDataModel, this.ena);
}

class BmiErrorState extends BmiState {
  String msg;
  BmiErrorState(this.msg);
}
