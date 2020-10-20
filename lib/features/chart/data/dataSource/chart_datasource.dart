import 'package:way2fitlife/features/chart/data/dataModel/chart_model.dart';

abstract class ChartDataSource {
  Future<ChartModel> getChartData({String dateType, String month});
}
