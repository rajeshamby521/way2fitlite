import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/forget_password/data/datamodel/forogt_password_data_model.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, ForgotPasswordDataModel>> forgotPassword(
      {String email});
}
