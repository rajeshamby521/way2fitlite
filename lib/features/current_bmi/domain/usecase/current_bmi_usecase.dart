import 'dart:math' as math;

class CalculateBMIUseCase {
  double bmr;

  double calculateBMR(double w, double h) {
    double weigth = w;
    double height = h;
    double hei = height / 100;

    double _bmr = weigth / math.pow(hei, 2);
    if (_bmr < 0) {
      _bmr = 0.1;
    }
    bmr = _bmr;

    return bmr.roundToDouble();
  }
}
