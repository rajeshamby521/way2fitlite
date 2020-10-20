import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/home/data/datasource/home_data_source.dart';
import 'package:way2fitlife/features/home/domain/repository/home_repository.dart';
import 'package:flutter/material.dart';

class HomeRepositoryImpl extends HomeRepository {
  HomeDataSource homeDataSource;

  HomeRepositoryImpl({@required this.homeDataSource});

  @override
  Future<Either<Failure, List<String>>> getData() async {
    final result = await homeDataSource.getData();
    return Right(result);
  }
}
