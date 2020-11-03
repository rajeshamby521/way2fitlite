import 'package:way2fitlife/features/forum/data/datamodel/add_forum_data_model.dart';
import 'package:way2fitlife/features/forum/data/datamodel/forum_data_model.dart';

abstract class ForumState {}

class ForumInitialState extends ForumState {}

class LoadingBeginHomeState extends ForumState {}

class LoadingEndHomeState extends ForumState {}

class LoadingBeginNextPageState extends ForumState {}

class LoadingEndNextPageState extends ForumState {}

class ForumFecthDataState extends ForumState {
  ForumDataModel model;

  ForumFecthDataState({this.model});
}

class ForumNextPageDataState extends ForumState {
  ForumDataModel model;

  ForumNextPageDataState({this.model});
}

class ForumErrorState extends ForumState {
  String msg;

  ForumErrorState({this.msg});
}

class AddForumBtnState extends ForumState {
  bool status;
  String topicMsg;
  String titleMsg;

  AddForumBtnState({this.status, this.topicMsg, this.titleMsg});
}

class AddForumState extends ForumState {
  AddForumDataModel model;

  AddForumState({this.model});
}
