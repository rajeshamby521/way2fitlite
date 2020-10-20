import 'dart:math' as math;

class CalculateBMIUseCase {
  double bmr;

  double calculateBMR(String w, String h) {
    double weigth = double.parse(w);
    double height = double.parse(h);
    double hei = height / 100;

    double _bmr = weigth / math.pow(hei, 2);
    if (_bmr < 0) {
      _bmr = 0.1;
    }
    bmr = _bmr;

    return bmr.roundToDouble();
  }
}
