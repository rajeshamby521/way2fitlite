import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/register_page/data/datamodel/register_data_model.dart';

abstract class RegisterRepository {
  Future<Either<Failure, RegisterDataModel>> getRegisterData();

  Future<Either<Failure, LogInModel>> sendRegisterData({
    RegisterDataModel registermodel,
  });
}
