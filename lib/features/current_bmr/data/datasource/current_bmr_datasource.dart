abstract class CurrentBMRDataSource {
  Future<double> getBMRData({double age, double weight, double height, bool gender});

  Future<double> getCaloriesData({String activity, double bmr});

  Future<bool> selectGenderData({bool gender});

  Future<String> selectActivityData({String activity});
}
