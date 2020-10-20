import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/chart/data/dataModel/chart_model.dart';

abstract class ChartRepository {
  Future<Either<Failure, ChartModel>> getChartData({String dateType, String month});
}
