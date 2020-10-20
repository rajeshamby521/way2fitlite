import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';

abstract class DashboardRepository {
  Future<Either<Failure, bool>> getAnimateData({bool animate});
}
