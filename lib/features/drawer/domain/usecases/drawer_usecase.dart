import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/drawer/domain/repository/drawer_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';

class DrawerUseCase extends UseCase<int, DrawerParams> {
  DrawerRepository repository;

  DrawerUseCase({this.repository});

  @override
  Future<Either<Failure, int>> call(DrawerParams params) async =>
      await repository.getData(pageNo: params.pageNo);
}

class DrawerParams extends Equatable {
  final int pageNo;

  DrawerParams({this.pageNo});

  @override
  List<Object> get props => [pageNo];
}
