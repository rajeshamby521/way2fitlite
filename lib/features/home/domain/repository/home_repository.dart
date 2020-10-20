
import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<String>>> getData();
}