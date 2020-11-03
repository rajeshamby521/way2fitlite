import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/register_page/data/datamodel/register_data_model.dart';
import 'package:way2fitlife/features/register_page/domain/repository/register_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';

/*class RegisterUseCase extends UseCase<RegisterDataModel, NoParams> {
  RegisterRepository registerRepository;

  RegisterUseCase({this.registerRepository});

  @override
  Future<Either<Failure, RegisterDataModel>> call(NoParams params) async {
    return await registerRepository.getRegisterData();
  }
}*/

class RegisterSendDataUseCase
    extends UseCase<LogInModel, RegisterUseCaseParams> {
  RegisterRepository registerRepository;

  RegisterSendDataUseCase({this.registerRepository});

  @override
  Future<Either<Failure, LogInModel>> call(RegisterUseCaseParams params) async {
    return await registerRepository.sendRegisterData(
      registermodel: params.model,
    );
  }
}

// ignore: must_be_immutable
class RegisterUseCaseParams extends Equatable {
  RegisterDataModel model;

  RegisterUseCaseParams({this.model});

  @override
  List<Object> get props => [model];
}
