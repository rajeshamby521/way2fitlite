import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';

abstract class DrawerRepository {
  Future<Either<Failure, int>> getData({int pageNo});
}
