import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/register_page/data/datamodel/register_data_model.dart';
import 'package:way2fitlife/features/update_user_data/data/datamodel/change_password_data_model.dart';
import 'package:way2fitlife/features/update_user_data/domain/repository/update_user_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';

class UpdateUserUseCase extends UseCase<LogInModel, UpdateUserUseCaseParams> {
  UpdateUserRepository updateUserRepository;

  UpdateUserUseCase({this.updateUserRepository});

  @override
  Future<Either<Failure, LogInModel>> call(
      UpdateUserUseCaseParams params) async {
    return await updateUserRepository.updateUserData(
      registermodel: params.model,
    );
  }
}

class ChangePasswordUseCase
    extends UseCase<ChangePasswordDataModel, ChangePasswordUseCaseParams> {
  UpdateUserRepository updateUserRepository;

  ChangePasswordUseCase({this.updateUserRepository});

  @override
  Future<Either<Failure, ChangePasswordDataModel>> call(
      ChangePasswordUseCaseParams params) async {
    return await updateUserRepository.changePassword(
      cpass: params.c_pass,
      npass: params.n_pass,
    );
  }
}

// ignore: must_be_immutable
class ChangePasswordUseCaseParams extends Equatable {
  String c_pass;
  String n_pass;

  ChangePasswordUseCaseParams({this.c_pass, this.n_pass});

  @override
  // TODO: implement props
  List<Object> get props => [c_pass, n_pass];
}

class UpdateUserUseCaseParams extends Equatable {
  RegisterDataModel model;

  UpdateUserUseCaseParams({this.model});

  @override
  // TODO: implement props
  List<Object> get props => [model];
}
