import 'package:way2fitlife/features/comment/data/datamodel/add_commmnet_model.dart';
import 'package:way2fitlife/features/comment/data/datamodel/forum_details_data_model.dart';

abstract class CommentDataResourse {
  Future<ForumDetailDataModel> getForumDetails({String id});

  Future<AddCommnetModel> addComment({String commnet});
}
