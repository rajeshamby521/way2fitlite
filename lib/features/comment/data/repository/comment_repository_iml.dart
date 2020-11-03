import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/comment/data/datamodel/add_commmnet_model.dart';
import 'package:way2fitlife/features/comment/data/datamodel/forum_details_data_model.dart';
import 'package:way2fitlife/features/comment/data/dataresourse/comment_data_resourse.dart';
import 'package:way2fitlife/features/comment/domian/repository/comment_repository.dart';

class CommentRepositoryIml extends CommentRepository {
  CommentDataResourse commentDataResourse;

  CommentRepositoryIml({this.commentDataResourse});

  @override
  Future<Either<Failure, ForumDetailDataModel>> getForumDetails(
      {String id}) async {
    final result = await commentDataResourse.getForumDetails(id: id);
    try {
      return Right(result);
    } on Failure {
      return Left(Failure(''));
    }
  }

  @override
  Future<Either<Failure, AddCommnetModel>> addComment({String comment}) async {
    final result = await commentDataResourse.addComment(commnet: comment);
    try {
      return Right(result);
    } on Failure {
      return Left(Failure(''));
    }
  }
}
