import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/forget_password/data/datamodel/forogt_password_data_model.dart';
import 'package:way2fitlife/features/forget_password/data/datasourse/forgot_password_data_resourse.dart';
import 'package:way2fitlife/features/forget_password/domain/repository/forgot_password_repository.dart';

class ForgotPasswordRepositoryIml extends ForgotPasswordRepository {
  ForgotPasswordDataResourse forgotPasswordDataResourse;

  ForgotPasswordRepositoryIml({this.forgotPasswordDataResourse});

  @override
  Future<Either<Failure, ForgotPasswordDataModel>> forgotPassword(
      {String email}) async {
    final result =
        await forgotPasswordDataResourse.fotgotPassword(email: email);
    try {
      return Right(result);
    } on Failure {
      return Left(Failure(''));
    }
  }
}
