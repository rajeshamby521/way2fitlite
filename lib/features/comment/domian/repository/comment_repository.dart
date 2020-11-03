import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/comment/data/datamodel/add_commmnet_model.dart';
import 'package:way2fitlife/features/comment/data/datamodel/forum_details_data_model.dart';

abstract class CommentRepository {
  Future<Either<Failure, ForumDetailDataModel>> getForumDetails({String id});
  Future<Either<Failure, AddCommnetModel>> addComment({String comment});
}
