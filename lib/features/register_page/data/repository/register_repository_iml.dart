import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/register_page/data/datamodel/register_data_model.dart';
import 'package:way2fitlife/features/register_page/data/datasource/register_data_source.dart';
import 'package:way2fitlife/features/register_page/domain/repository/register_repository.dart';

class RegisterRepositoryIml extends RegisterRepository {
  RegisterDataSource registerDataSource;

  RegisterRepositoryIml({this.registerDataSource});

  @override
  Future<Either<Failure, RegisterDataModel>> getRegisterData() async {
    final result = await registerDataSource.getRegisterData();
    try {
      return Right(result);
    } on Failure {
      return Left(Failure(''));
    }
  }

  @override
  Future<Either<Failure, LogInModel>> sendRegisterData(
      {RegisterDataModel registermodel}) async {
    final result =
        await registerDataSource.sendRegisterData(registermodel: registermodel);
    try {
      return Right(result);
    } on Failure {
      return Left(Failure(''));
    }
  }
}
