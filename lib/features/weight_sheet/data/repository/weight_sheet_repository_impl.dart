import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/weight_sheet/data/datamodel/set_weight_data_model.dart';
import 'package:way2fitlife/features/weight_sheet/data/datamodel/weight_sheet_model.dart';
import 'package:way2fitlife/features/weight_sheet/data/datasource/weight_sheet_datasource.dart';
import 'package:way2fitlife/features/weight_sheet/domain/repository/weight_sheet_repository.dart';

class WeightSheetRepositoryImpl extends WeightSheetRepository {
  WeightSheetDataSource weightSheetDataSource;

  WeightSheetRepositoryImpl({this.weightSheetDataSource});

  @override
  Future<Either<Failure, WeightSheetModel>> getWeightSheetData({int offSet}) async {
    final result = await weightSheetDataSource.getWeightSheetData(offSet: offSet);
    return Right(result);
  }

  @override
  Future<Either<Failure, double>> getWeight({double weight}) async {
    final result = await weightSheetDataSource.getWeight(weight: weight);
    return Right(result);
  }

  @override
  Future<Either<Failure, DateTime>> getDate({DateTime dateTime}) async {
    final result = await weightSheetDataSource.getDate(dateTime: dateTime);
    return Right(result);
  }

  @override
  Future<Either<Failure, SetWeightDataModel>> setWeightSheetData({String date, String weight}) async {
    final result = await weightSheetDataSource.setWeightSheetData(date: date, weight: weight);
    return Right(result);
  }
}
