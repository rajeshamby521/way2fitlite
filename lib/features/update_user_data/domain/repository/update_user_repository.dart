import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/register_page/data/datamodel/register_data_model.dart';
import 'package:way2fitlife/features/update_user_data/data/datamodel/change_password_data_model.dart';

abstract class UpdateUserRepository {
  Future<Either<Failure, LogInModel>> updateUserData({
    RegisterDataModel registermodel,
  });
  Future<Either<Failure, ChangePasswordDataModel>> changePassword({
    String cpass,
    String npass,
  });
}
