import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/register_page/data/datamodel/register_data_model.dart';
import 'package:way2fitlife/features/update_user_data/data/datamodel/change_password_data_model.dart';
import 'package:way2fitlife/features/update_user_data/data/dataresourse/update_user_data_resourse.dart';
import 'package:way2fitlife/features/update_user_data/domain/repository/update_user_repository.dart';

class UpdateUserRepositoryIml extends UpdateUserRepository {
  UpdateUserDataResourse updateUserDataResourse;

  UpdateUserRepositoryIml({this.updateUserDataResourse});

  @override
  Future<Either<Failure, LogInModel>> updateUserData(
      {RegisterDataModel registermodel}) async {
    final result = await updateUserDataResourse.updateUserData(
        registerDataModel: registermodel);
    try {
      return Right(result);
    } on Failure {
      return Left(Failure(''));
    }
  }

  @override
  Future<Either<Failure, ChangePasswordDataModel>> changePassword(
      {String cpass, String npass}) async {
    final result = await updateUserDataResourse.changePassword(
        c_pass: cpass, n_pass: npass);
    try {
      return Right(result);
    } on Failure {
      return Left(Failure(''));
    }
  }
}
