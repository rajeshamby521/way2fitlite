import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/weight_sheet/data/datamodel/set_weight_data_model.dart';
import 'package:way2fitlife/features/weight_sheet/data/datamodel/weight_sheet_model.dart';

abstract class WeightSheetRepository {
  Future<Either<Failure, WeightSheetModel>> getWeightSheetData({int offSet});

  Future<Either<Failure, SetWeightDataModel>> setWeightSheetData({String date, String weight});

  Future<Either<Failure, double>> getWeight({double weight});

  Future<Either<Failure, DateTime>> getDate({DateTime dateTime});
}
