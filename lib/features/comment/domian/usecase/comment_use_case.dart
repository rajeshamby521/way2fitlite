import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/comment/data/datamodel/add_commmnet_model.dart';
import 'package:way2fitlife/features/comment/data/datamodel/forum_details_data_model.dart';
import 'package:way2fitlife/features/comment/domian/repository/comment_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';

class ForumDetailsUseCase
    extends UseCase<ForumDetailDataModel, ForumDetailsUseCaseParams> {
  CommentRepository commentRepository;

  ForumDetailsUseCase({this.commentRepository});

  @override
  Future<Either<Failure, ForumDetailDataModel>> call(
      ForumDetailsUseCaseParams params) async {
    return await commentRepository.getForumDetails(id: params.forum_id);
  }
}

class ForumDetailsUseCaseParams extends Equatable {
  String forum_id;

  ForumDetailsUseCaseParams({this.forum_id});

  @override
  // TODO: implement props
  List<Object> get props => [forum_id];
}

class AddCommnetUseCase
    extends UseCase<AddCommnetModel, AddCommentUseCaseParams> {
  CommentRepository commentRepository;

  AddCommnetUseCase({this.commentRepository});

  @override
  Future<Either<Failure, AddCommnetModel>> call(
      AddCommentUseCaseParams params) async {
    return await commentRepository.addComment(comment: params.comment);
  }
}

class AddCommentUseCaseParams extends Equatable {
  String comment;

  AddCommentUseCaseParams({this.comment});

  @override
  List<Object> get props => [comment];
}
