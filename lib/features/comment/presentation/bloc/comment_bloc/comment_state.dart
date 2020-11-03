import 'package:way2fitlife/features/comment/data/datamodel/add_commmnet_model.dart';
import 'package:way2fitlife/features/comment/data/datamodel/forum_details_data_model.dart';

abstract class CommentState {}

class CommentIntialState extends CommentState {}

class ForumDetaislState extends CommentState {
  ForumDetailDataModel model;

  ForumDetaislState({this.model});
}

class CommentLoadingBeginState extends CommentState {}

class CommentLoadingEndState extends CommentState {}

class CommentErrorState extends CommentState {
  String msg;

  CommentErrorState({this.msg});
}

class AddCommentinitState extends CommentState {}

class AddCommentBtnState extends CommentState {
  bool staus;
  String commnetMsg;

  AddCommentBtnState({this.staus, this.commnetMsg});
}

class AddCommentclickState extends CommentState {
  AddCommnetModel model;

  AddCommentclickState({this.model});
}
