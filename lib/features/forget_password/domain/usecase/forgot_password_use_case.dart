import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/forget_password/data/datamodel/forogt_password_data_model.dart';
import 'package:way2fitlife/features/forget_password/domain/repository/forgot_password_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';

class ForgotPasswordUseCase
    extends UseCase<ForgotPasswordDataModel, ForgotPasswordUseCaseParams> {
  ForgotPasswordRepository forgotPasswordRepository;

  ForgotPasswordUseCase({this.forgotPasswordRepository});

  @override
  Future<Either<Failure, ForgotPasswordDataModel>> call(
      ForgotPasswordUseCaseParams params) async {
    return await forgotPasswordRepository.forgotPassword(
      email: params.email,
    );
  }
}

class ForgotPasswordUseCaseParams extends Equatable {
  String email;

  ForgotPasswordUseCaseParams({this.email});

  @override
  // TODO: implement props
  List<Object> get props => [email];
}
