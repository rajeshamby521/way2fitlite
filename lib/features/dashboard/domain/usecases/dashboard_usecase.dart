import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';
import 'package:flutter/material.dart';

class DashboardAnimateUseCase extends UseCase<bool, DashboardAnimateParams> {
  DashboardRepository repository;

  DashboardAnimateUseCase({@required this.repository});

  @override
  Future<Either<Failure, bool>> call(DashboardAnimateParams params) async {
    return await repository.getAnimateData(animate: params.animate);
  }
}

class DashboardAnimateParams extends Equatable {
  final bool animate;

  DashboardAnimateParams({this.animate});

  @override
  List<Object> get props => [animate];
}
