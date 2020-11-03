import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/forum/data/datamodel/add_forum_data_model.dart';
import 'package:way2fitlife/features/forum/data/datamodel/forum_data_model.dart';
import 'package:way2fitlife/features/forum/data/dataresourse/forum_data_resourse.dart';
import 'package:way2fitlife/features/forum/domain/repository/forum_repository.dart';

class ForumRepositoryIml extends ForumRepository {
  ForumDataResourse forumDataResourse;

  ForumRepositoryIml({this.forumDataResourse});

  @override
  Future<Either<Failure, ForumDataModel>> getForumData({int offset}) async {
    final result = await forumDataResourse.getData(offSet: offset);
    try {
      return Right(result);
    } on Failure {
      return Left(Failure(''));
    }
  }

  @override
  Future<Either<Failure, AddForumDataModel>> addForumData(
      {String topic, String title, String desc}) async {
    final result = await forumDataResourse.addForumData(
        topic: topic, title: title, desc: desc);
    try {
      return Right(result);
    } on Failure {
      return Left(Failure(''));
    }
  }
}
