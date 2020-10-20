import 'package:meta/meta.dart';

@immutable
abstract class CurrentBMRState {}

class InitialCurrentBMRState extends CurrentBMRState {}

// class LoadingBeginCurrentState extends CurrentBMRState {}

// class LoadingEndHomeState extends CurrentBMRState {}

class ErrorState extends CurrentBMRState {
  final String message;

  ErrorState(this.message);
}

class CalculateBMRState extends CurrentBMRState {
  double bmr;

  CalculateBMRState({this.bmr});
}

class CalculateCaloriesState extends CurrentBMRState {
  double calories;

  CalculateCaloriesState({this.calories});
}

class SelectActivityState extends CurrentBMRState {
  String activity;

  SelectActivityState({this.activity});
}

class SelectGenderState extends CurrentBMRState {
  bool gender;

  SelectGenderState({this.gender});
}
