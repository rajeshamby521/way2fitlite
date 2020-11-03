import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/forum/data/datamodel/add_forum_data_model.dart';
import 'package:way2fitlife/features/forum/data/datamodel/forum_data_model.dart';
import 'package:way2fitlife/features/forum/domain/repository/forum_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';

class ForumfetchUseCase
    extends UseCase<ForumDataModel, ForumFectDataUseCaseParams> {
  ForumRepository forumRepository;

  ForumfetchUseCase({this.forumRepository});

  @override
  Future<Either<Failure, ForumDataModel>> call(
      ForumFectDataUseCaseParams params) async {
    return await forumRepository.getForumData(offset: params.offset);
  }
}

class ForumFectDataUseCaseParams extends Equatable {
  int offset;

  ForumFectDataUseCaseParams({this.offset});

  @override
  // TODO: implement props
  List<Object> get props => [offset];
}

class AddForumUseCase
    extends UseCase<AddForumDataModel, AddForumUseCaseParams> {
  ForumRepository forumRepository;

  AddForumUseCase({this.forumRepository});

  @override
  Future<Either<Failure, AddForumDataModel>> call(
      AddForumUseCaseParams params) async {
    return await forumRepository.addForumData(
        title: params.title, topic: params.topic, desc: params.desc);
  }
}

class AddForumUseCaseParams extends Equatable {
  String topic;
  String title;
  String desc;

  AddForumUseCaseParams({this.topic, this.title, this.desc});

  @override
  // TODO: implement props
  List<Object> get props => [topic, title, desc];
}
