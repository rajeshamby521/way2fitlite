import 'package:way2fitlife/features/current_bmr/data/datasource/current_bmr_datasource.dart';
import 'package:way2fitlife/ui_helper/strings.dart';

class CurrentBMRDataSourceImpl extends CurrentBMRDataSource {
  @override
  Future<double> getBMRData({
    double age,
    double weight,
    double height,
    bool gender,
  }) async {
    return !gender
        ? (88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age))
        : (447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age));
  }

  @override
  Future<double> getCaloriesData({String activity, double bmr}) async {
    switch (activity) {
      case normal:
        return 1.2 * bmr;
        break;
      case light:
        return 1.375 * bmr;
        break;
      case medium:
        return 1.55 * bmr;
        break;
      case active:
        return 1.725 * bmr;
        break;
      default:
        return 0;
        break;
    }
  }

  @override
  Future<bool> selectGenderData({bool gender}) async => gender;

  @override
  Future<String> selectActivityData({String activity}) async => activity;
}
