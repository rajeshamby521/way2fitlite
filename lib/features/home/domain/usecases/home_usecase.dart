import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/home/domain/repository/home_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';
import 'package:flutter/material.dart';

class HomeUseCase extends UseCase<List<String>, HomeDataParams> {
  HomeRepository repository;

  HomeUseCase({@required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(HomeDataParams params) async {
    return await repository.getData();
  }
}

class HomeDataParams extends Equatable {
  @override
  List<Object> get props => [];
}
