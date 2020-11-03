import 'package:way2fitlife/features/comment/data/datamodel/add_commmnet_model.dart';

abstract class AddCommentState {}

class AddCommentinitState extends AddCommentState {}

class AddCommnetErrorState extends AddCommentState {
  String msg;

  AddCommnetErrorState({this.msg});
}

class AddCommentBtnState extends AddCommentState {
  bool staus;
  String commnetMsg;

  AddCommentBtnState({this.staus, this.commnetMsg});
}

class AddCommentclickState extends AddCommentState {
  AddCommnetModel model;

  AddCommentclickState({this.model});
}
