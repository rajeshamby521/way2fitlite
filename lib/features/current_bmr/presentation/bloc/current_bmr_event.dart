abstract class CurrentBMREvent {}

class CalculateBMREvent extends CurrentBMREvent {
  double age;
  double weight;
  double height;
  bool gender;

  CalculateBMREvent({this.age, this.height, this.weight, this.gender});
}

class CalculateCaloriesEvent extends CurrentBMREvent {
  double bmr;
  String activity;

  CalculateCaloriesEvent({this.bmr, this.activity});
}

class SelectActivityEvent extends CurrentBMREvent {
  String activity;

  SelectActivityEvent({this.activity});
}

class SelectGenderEvent extends CurrentBMREvent {
  bool gender;

  SelectGenderEvent({this.gender});
}
