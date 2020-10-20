import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
